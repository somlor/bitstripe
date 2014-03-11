# class GenerateInvoice
#   # attr_reader :invoice, :bitcoin_address

#   # def initialize(opts = {})
#   #   raise StandardError::TypeError unless opts[:bitcoin_address].is_a?(BitcoinAddress)
#   #   @bitcoin_address = opts[:bitcoin_address]
#   # end

#   def self.create(opts = {})
#     raise StandardError::TypeError unless opts[:satoshi_cost].is_a?(Integer)
#     raise StandardError::TypeError unless opts[:bitcoin_address].is_a?(BitcoinAddress)

#     satoshi_cost = opts[:satoshi_cost]
#     bitcoin_address = opts[:bitcoin_address]
#     invoice = Invoice.create(satoshi_cost: satoshi_cost,
#                              user: bitcoin_address.user,
#                              destination_address: bitcoin_address,
#                              auth_token: SecureRandom.urlsafe_base64(32))

#     callback_params = { invoice_id: invoice.id,
#                         auth_token: invoice.auth_token }
#     callback_url = "http://seanomlor.com/?#{callback_params.to_query}"

#     response = BlockchainInfoAPI.receive(address: bitcoin_address.address,
#                                          callback: callback_url)

#     forwarding_address = bitcoin_address.add_forwarder(response["input_address"])
#     invoice.update_attribute(:forwarding_address, forwarding_address)
#     invoice
#   end
# end
