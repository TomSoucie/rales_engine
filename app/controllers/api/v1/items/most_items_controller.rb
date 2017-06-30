class Api::V1::Items::MostItemsController < ApplicationController

  def index
    render json: Item.top_x_items_sold(params["quantity"])
  end
end
