# require 'spec_helper'

# describe GenerateInvoice do
#   let(:user) { User.create(email: "test@example.com") }
#   let!(:bitcoin_address) { BitcoinAddress.create(user: user, address: "abc") }
#   let(:invoice_params) { { satoshi_cost: 100000,
#                            bitcoin_address: bitcoin_address }}

#   describe "#create" do
#     it "creates a new invoice" do
#       expect { GenerateInvoice.create(invoice_params) }.to change(Invoice, :count).by(1)
#     end

#     it "creates a new forwarding bitcoin_address" do
#       expect { GenerateInvoice.create(invoice_params) }.to change(BitcoinAddress, :count).by(1)
#     end

#     it "new invoice created has a forwarding address" do
#       invoice = GenerateInvoice.create(invoice_params)
#       expect(invoice.forwarding_address).to be_present
#       expect(invoice.forwarding_address.address).not_to be_empty
#     end
#   end
# end
