class Api::V1::ItemsController < ApplicationController
  def index
    render json: Item.all
  end

  def show
    # binding.pry
    render json: Item.find(params[:id])
  end
end
