# == Schema Information
#
# Table name: payments
#
#  id                           :integer          not null, primary key
#  satoshi_paid                 :integer
#  invoice_id                   :integer
#  destination_address_id       :integer
#  destination_transaction_hash :string(255)
#  forwarding_address_id        :integer
#  forwarding_transaction_hash  :string(255)
#  confirmations                :integer
#  created_at                   :datetime
#  updated_at                   :datetime
#

class Payment < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :destination_address, class_name: 'BitcoinAddress'
  belongs_to :forwarding_address, class_name: 'BitcoinAddress'

  validates_presence_of :satoshi_paid, :destination_transaction_hash,
                        :forwarding_transaction_hash, :confirmations,
                        :invoice, :destination_address, :forwarding_address
  validates_numericality_of :satoshi_paid, only_integer: true

end
