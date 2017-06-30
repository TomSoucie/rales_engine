class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    merchant = Merchant.find(params["id"])
    formatted_revenue = sprintf('%.2f', (merchant.revenue/100.0))
    render json: {"revenue" => formatted_revenue}
  end
end
