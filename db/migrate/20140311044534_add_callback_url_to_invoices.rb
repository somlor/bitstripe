class AddCallbackUrlToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :callback_url, :string
  end
end
