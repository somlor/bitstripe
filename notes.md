bitstripe:
==========

MAKE A TEST PAYMENT PAGE THAT POSTS TO PAYMENTS:
http://localhost:3000/payments
/?invoice_id=1&auth_token=QQK2CpIfSpiWkw681J-UIiZXlrYA5mVkRCcWfnEAwiQ&value=15000000&confirmations=3&destination_address=1JyhRJD2LUZe2oBdHMti64BEfxdufrJsLy&input_address=1HYsYHtT7G1GoURMX9C6bcve9kR7wzptnX&input_transaction_hash=ith&destination_transaction_hash=dth

user
  email:string
  password....
  has_many :bitcoin_addresses
  has_many :invoices

bitcoin_address
  address:string
  user_id:integer
  destination_address_id:integer
  belongs_to :destination_address, class_name: 'BitcoinAddress'
  has_many :forwarding_addresses, class_name: 'BitcoinAddress', foreign_key: :destination_address_id

invoice
  satoshi_cost:integer # 1 satoshi = 0.00000001 btc
  user_id:integer
  destination_address_id:integer
  forwarding_address_id:integer
  auth_token:string

  belongs_to :user
  belongs_to :destination_address_id, class_name: 'BitcoinAddress'
  belongs_to :forwarding_address_id, class_name: 'BitcoinAddress'
  has_many :payments

payment
  satoshi:integer
  invoice_id:integer # passed via callback
  destination_address_id:integer
  destination_transaction_hash:string
  forwarding_address_id:integer
  forwarding_transaction_hash:string
  confirmations:integer

----------

def status
  if satoshi_paid >= satoshi_due
    :paid_full
  elsif satoshi_paid > 0
    :paid_partial
  else
    :unpaid
  end
end

def btc_to_satoshi(btc)
  raise if btc < 0.00000001
  btc / 0.00000001
end

def satoshi_to_btc(satoshi)
  btc = satoshi * 0.00000001
  btc_str = "%.8f" % btc
  satoshi.to_s.length >= 8 ? btc : btc_str
end

