class CreateBitcoinAddresses < ActiveRecord::Migration
  def change
    create_table :bitcoin_addresses do |t|
      t.string :address
      t.integer :user_id
      t.integer :destination_address_id

      t.timestamps
    end
  end
end
