require 'webmock'
include WebMock::API
WebMock.disable_net_connect!(allow_localhost: true)

module MockBlockchainInfoServer
    stub_request(:get, /blockchain.info\/api\/receive/).
      to_return(status: 200,
                headers: {},
                body: '{ "input_address": "' + SecureRandom.urlsafe_base64(32) + '",
                         "destination": "1JyhRJD2LUZe2oBdHMti64BEfxdufrJsLy",
                         "fee_percent": 0,
                         "callback_url": "http://example.com?test=true" }')

  # def self.mock_request(options = {})
  #   stub_request(:get, /blockchain.info\/api\/receive/).to_return(mock_response)
  # end

  # def self.mock_response
  #   { status: 200,
  #     headers: {},
  #     body: '{ "input_address": "15c7xPH55Ek6bUvFbonifwViYP3jkz1nq7",
  #              "fee_percent": 0,
  #              "destination": "1JyhRJD2LUZe2oBdHMti64BEfxdufrJsLy",
  #              "callback_url": "http://example.com?test=true" }' }
  # end
end
