class Api::V1::Merchants::InvoiceContorller < ApplicationController
  def index
    render json: Merchant.find(params["id"]).items
  end
end 
