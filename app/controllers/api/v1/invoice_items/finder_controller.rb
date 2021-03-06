class Api::V1::InvoiceItems::FinderController < ApplicationController
  def index
    render json: InvoiceItem.where(invoice_item_params)
  end

  def show
    render json: InvoiceItem.find_by(invoice_item_params)
  end

  private

    def unit_price_adjust(whitelist)
      if whitelist["unit_price"]
        whitelist["unit_price"] = whitelist["unit_price"].gsub('.', '')
      end
      return whitelist
    end

    def invoice_item_params
      unit_price_adjust(params.permit(:id,
                    :item_id,
                    :invoice_id,
                    :quantity,
                    :unit_price,
                    :updated_at,
                    :created_at))
    end
end
