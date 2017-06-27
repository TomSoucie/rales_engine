class Api::V1::InvoicesItemsController < ApplicationController
  def index
    render json: InvoicesItem.all
  end

  def show
    render json: InvoicesItem.find(params[:id])
  end
end
