class Api::V1::Invoices::FinderController < ApplicationController
  def index
    render json: Invoice.where(invoice_params)
  end

  def show
    render json: Invoice.find_by(invoice_params)
  end

  private

    def invoice_params
      params.permit(:id,
                    :customer_id,
                    :merchant_id,
                    :status,
                    :updated_at,
                    :created_at)
    end
end
