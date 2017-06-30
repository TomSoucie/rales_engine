class Api::V1::Merchants::MostItemsController < ApplicationController

  def index
    render json: Merchant.top_x_merchants_items(params["quantity"])
  end
end
