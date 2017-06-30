class Api::V1::Merchants::AllRevenueController < ApplicationController
  def index
    render json: Merchant.top_x_merchants_revenue(params["quantity"])
  end

  def show
    render json: Merchant.revenue_on_date(params["date"])
  end
end
