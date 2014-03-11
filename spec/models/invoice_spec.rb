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

require 'spec_helper'

describe Invoice do
  let!(:user) { User.create(email: "test@example.com",
                            password: "12345678",
                            password_confirmation: "12345678") }

  let!(:bitcoin_address) { BitcoinAddress.create(user: user,
                                                 address: "abc") }

  let!(:invoice_params) { { user_id: user.id,
                            btc_cost: 0.25,
                            destination_address_id: bitcoin_address.id }}

  it "creates an invoice" do
    expect { Invoice.create(invoice_params) }.to change(Invoice, :count).by(1)
  end

  it "generates a new forwarding bitcoin_address after create" do
    expect { Invoice.create(invoice_params) }.to change(BitcoinAddress, :count).by(1)
  end

  it "invoice created has a forwarding address" do
    invoice = Invoice.create(invoice_params)
    expect(invoice.forwarding_address).to be_present
    expect(invoice.forwarding_address.address).not_to be_empty
  end
end
