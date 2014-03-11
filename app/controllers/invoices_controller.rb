class InvoicesController < ApplicationController
  before_filter :redirect_unless_logged_in

  def index
    @invoices = current_user.invoices
    @invoice = Invoice.new
  end

  def create
    invoice = current_user.invoices.build(invoice_params)
    if invoice.save
      redirect_to invoices_url
    else
      render json: invoice.errors
    end
  end

  def show
    @invoice = current_user.invoices.find(params[:id])
  end

  private

  def invoice_params
    params.require(:invoice)
          .permit(:btc_cost, :destination_address_id)
          .merge(callback_url: payments_url)
  end
end
