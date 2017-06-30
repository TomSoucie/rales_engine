class Api::V1::Items::FinderController < ApplicationController
  def index
    render json: Item.where(item_params)
  end

  def show
    render json: Item.where(item_params).first
  end

  private

    def unit_price_adjust(whitelist)
      if whitelist["unit_price"]
        whitelist["unit_price"] = whitelist["unit_price"].gsub('.', '')
      end
      return whitelist
    end

    def item_params
      unit_price_adjust(params.permit(:id,
                    :name,
                    :description,
                    :unit_price,
                    :merchant_id,
                    :updated_at,
                    :created_at))
    end
end
