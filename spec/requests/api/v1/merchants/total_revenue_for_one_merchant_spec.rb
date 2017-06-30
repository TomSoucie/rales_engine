require 'rails_helper'

describe "GET /api/v1/merchants/:id/revenue" do
  xit "can return the total revenue for a single merchant" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    invoice_success = create(:invoice, merchant: merchant)
    transaction_success = create(:transaction, result: "success", invoice: invoice_success)
    invoice_item_1 = create(:invoice_item, item: item, invoice: invoice_success)


    invoice_fail = create(:invoice, merchant: merchant)
    transaction_fail = create(:transaction, result: "failed", invoice: invoice_fail)
    invoice_item_2 = create(:invoice_item, item: item, invoice: invoice_fail)

    get "/api/v1/merchants/#{merchant.id}/revenue"

    expect(response).to be_success

    json = JSON.parse(response.body)

    expect(json).to have_key("revenue")
    expect(json["revenue"]).to eq("10.00")
  end
end
