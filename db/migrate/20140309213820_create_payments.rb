class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :satoshi_paid
      t.integer :invoice_id
      t.integer :destination_address_id
      t.string :destination_transaction_hash
      t.integer :forwarding_address_id
      t.string :forwarding_transaction_hash
      t.integer :confirmations

      t.timestamps
    end
  end
end
