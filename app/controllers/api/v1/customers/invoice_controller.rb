class Api::V1::Customers::InvoiceController < ApplicationController

  def index
    render json: Customer.find(params["id"]).invoices
  end
end
