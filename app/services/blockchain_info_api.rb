class BlockchainInfoAPI
  # https://blockchain.info/api/api_receive
  def self.receive(opts = {})
    raise StandardError::TypeError unless opts[:address].is_a?(String)

    api_params = { method: "create",
                   address: opts[:address],
                   callback: opts[:callback] }
    api_url = "https://blockchain.info/api/receive?#{api_params.to_query}"

    response = HTTParty.get(api_url)
    JSON.parse(response.body)
  end
end
