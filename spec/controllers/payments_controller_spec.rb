require 'spec_helper'

describe PaymentsController do
  describe 'POST #create' do
    let!(:invoice) { FactoryGirl.create(:invoice) }
    let(:params) { { invoice_id: invoice.id,
                     auth_token: invoice.auth_token,
                     destination_address: invoice.destination_address.address,
                     transaction_hash: "dth",
                     input_address: invoice.forwarding_address.address,
                     input_transaction_hash: "fth",
                     value: 15000000,
                     confirmations: 3 } }

    it "creates a payment" do
      post 'create', params
      expect(response.status).to eq(200)
    end
  end
end
