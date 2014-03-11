class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :satoshi_cost
      t.integer :user_id
      t.integer :destination_address_id
      t.integer :forwarding_address_id
      t.string :auth_token

      t.timestamps
    end
  end
end
