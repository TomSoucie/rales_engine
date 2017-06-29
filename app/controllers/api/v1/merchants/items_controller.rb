class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    render json: Item.find(params["id"]).item
  end
end
