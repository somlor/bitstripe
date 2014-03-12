# require_dependency 'bitcoin_conversion'
require_dependency 'form_object'
require_dependency 'mock_blockchain_info_server' unless Rails.env.production?

class UserInvoiceForm < FormObject
  attr_reader :invoice, :destination_address, :forwarding_adress

  attribute :user, User
  attribute :btc_cost, Float
  attribute :satoshi_cost, Integer
  attribute :destination_address, BitcoinAddress
  attribute :destination_address_id, Integer
  attribute :forwarding_address, BitcoinAddress
  attribute :auth_token, String
  attribute :callback_url, String

  private

  def persist!
    destination_address = user.bitcoin_addresses.find(destination_address_id)

    @invoice = user.invoices.create(auth_token: generate_auth_token,
                                    callback_url: callback_url,
                                    destination_address: destination_address,
                                    satoshi_cost: calc_satoshi_cost)

    invoice.update_attribute(:forwarding_address, generate_forwarding_address)
  end

  def generate_auth_token
    SecureRandom.urlsafe_base64(32)
  end

  def generate_forwarding_address
    bci_callback_params = { invoice_id: invoice.id,
                            auth_token: invoice.auth_token }

    bci_callback_url = "#{invoice.callback_url}?#{bci_callback_params.to_query}"

    response = BlockchainInfoAPI.receive(address: invoice.destination_address.address,
                                         callback: bci_callback_url)

    user.bitcoin_addresses.create(address: response["input_address"],
                                  destination_address: invoice.destination_address)
  end

  def calc_satoshi_cost
    if btc_cost.present? && satoshi_cost.blank?
      btc_to_satoshi(btc_cost)
    else
      satoshi_cost
    end
  end

  def btc_to_satoshi(btc)
    btc = btc.to_f
    raise if btc < 0.00000001
    (btc / 0.00000001).to_i
  end
end
