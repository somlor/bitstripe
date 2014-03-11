class PaymentsController < ApplicationController
  def create
    invoice = Invoice.find(params[:invoice_id])
    if invoice.auth_token == params[:auth_token]
      destination_address = BitcoinAddress.find_by_address(params[:destination_address])
      forwarding_address = BitcoinAddress.find_by_address(params[:input_address])

      payment_params = { satoshi_paid: params[:value].to_i,
                         destination_address: destination_address,
                         destination_transaction_hash: params[:transaction_hash],
                         forwarding_address: forwarding_address,
                         forwarding_transaction_hash: params[:input_transaction_hash],
                         confirmations: params[:confirmations].to_i }

      payment = invoice.payments.build(payment_params)

      if payment.save
        render json: payment, status: :ok
      else
        p "[PAYMENT ERROR]"
        p payment.errors.messages
        render nothing: true, status: :unprocessable_entity
      end
    else
      render nothing: true, status: :unauthorized
    end
  end

  def test
    @invoices = current_user.invoices
  end
end
