# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  session_key     :string(255)
#

class User < ActiveRecord::Base
  has_many :bitcoin_addresses
  has_many :invoices

  validates_uniqueness_of :email
  validates_presence_of :email, :password_digest
  validates_length_of :password, { minimum: 8 }

  has_secure_password

  def destination_bitcoin_addresses
    bitcoin_addresses.where(destination_address_id: nil)
  end

  def forwarding_bitcoin_addresses
    bitcoin_addresses.where.not(destination_address_id: nil)
  end
end
