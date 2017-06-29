class Api::V1::Merchants::InvoicesContorller < ApplicationController
  def index
    render json: Merchant.find(params["id"]).invoices
  end
end
