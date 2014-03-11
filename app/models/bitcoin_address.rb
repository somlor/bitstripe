# == Schema Information
#
# Table name: bitcoin_addresses
#
#  id                     :integer          not null, primary key
#  address                :string(255)
#  user_id                :integer
#  destination_address_id :integer
#  created_at             :datetime
#  updated_at             :datetime
#

class BitcoinAddress < ActiveRecord::Base
  belongs_to :user
  belongs_to :destination_address, class_name: 'BitcoinAddress'
  has_many :forwarding_addresses, class_name: 'BitcoinAddress', foreign_key: :destination_address_id

  validates_presence_of :address, :user
  validates_uniqueness_of :address

  def add_forwarder(forwarding_address)
    forwarding_addresses.create(user: user,
                                address: forwarding_address)
  end
end
