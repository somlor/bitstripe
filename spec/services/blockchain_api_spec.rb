require 'spec_helper'

describe BlockchainInfoAPI do
  describe "#receive" do
    let(:bitcoin_address) { "1JyhRJD2LUZe2oBdHMti64BEfxdufrJsLy" }
    let(:callback_url) { "http://example.com?test=true" }

    it "takes a bitcoin address and callback params and returns parsed JSON" do
      response = BlockchainInfoAPI.receive(address: bitcoin_address,
                                           callback: callback_url)
      expect(response).to include("input_address")
      expect(response).to include("fee_percent")
      expect(response).to include("destination")
      expect(response).to include("callback_url")
    end
  end
end
