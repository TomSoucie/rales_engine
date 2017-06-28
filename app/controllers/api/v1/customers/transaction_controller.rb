class Api::V1::Customers::TransactionController < ApplicationController

  def index
    render json: Customer.find(params["id"]).transactions
  end
end
