# == Schema Information
#
# Table name: invoices
#
#  id                     :integer          not null, primary key
#  satoshi_cost           :integer
#  user_id                :integer
#  destination_address_id :integer
#  forwarding_address_id  :integer
#  auth_token             :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  callback_url           :string(255)
#

require_dependency 'blockchain_info_server' unless Rails.env.production?
require 'bitcoin_conversion'

class Invoice < ActiveRecord::Base
  attr_accessor :btc_cost

  belongs_to :user
  belongs_to :destination_address, class_name: 'BitcoinAddress'
  belongs_to :forwarding_address, class_name: 'BitcoinAddress'
  has_many :payments

  validates_presence_of :satoshi_cost, :user, :destination_address
  validates_numericality_of :satoshi_cost, greater_than_or_equal_to: 100000, only_integer: true # == 0.001 BTC

  before_validation :convert_btc_to_satoshi
  before_create :generate_auth_token
  after_create :add_forwarding_address

  def status
    if satoshi_paid == satoshi_due
      :paid_full
    elsif satoshi_paid > satoshi_due
      :paid_over
    elsif satoshi_paid > 0
      :paid_partial
    else
      :unpaid
    end
  end

  def satoshi_paid
    payments.pluck(:satoshi_paid).reduce(&:+) || 0
  end

  def satoshi_due
    satoshi_cost - satoshi_paid
  end

  def cost_in_btc
    BitcoinConversion.satoshi_to_btc(self.satoshi_cost)
  end

  def generate_auth_token
    self.auth_token = SecureRandom.urlsafe_base64(32)
  end

  def convert_btc_to_satoshi
    if btc_cost.present? && satoshi_cost.blank?
      self.satoshi_cost = BitcoinConversion.btc_to_satoshi(btc_cost)
    end
  end

  def add_forwarding_address
    bci_callback_params = { invoice_id: self.id,
                            auth_token: self.auth_token }
    bci_callback_url = "#{self.callback_url}?#{bci_callback_params.to_query}"

    response = BlockchainInfoAPI.receive(address: self.destination_address.address,
                                         callback: bci_callback_url)

    forwarding_address = self.destination_address.add_forwarder(response["input_address"])
    self.forwarding_address = forwarding_address
    save!
  end
end
