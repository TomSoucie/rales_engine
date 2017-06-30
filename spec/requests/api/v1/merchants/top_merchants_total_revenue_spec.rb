require 'rails_helper'

describe "GET request to merchants with /most_revenue" do
  it "returns the top x merchants ranked by total revenue" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id, unit_price: 1000)
    item2 = create(:item, merchant_id: merchant2.id, unit_price: 1000)
    invoice1 = create(:invoice, merchant_id: merchant1.id)
    invoice2 = create(:invoice, merchant_id: merchant2.id)
    invoice_item1 = create(:invoice_item,
                            invoice_id: invoice1.id,
                            item_id: item1.id,
                            quantity: 2,
                            unit_price: 1000)
    invoice_item2 = create(:invoice_item,
                            invoice_id: invoice2.id,
                            item_id: item2.id,
                            quantity: 1,
                            unit_price: 1000)
    create(:transaction, invoice_id: invoice1.id, result: "success")
    create(:transaction, invoice_id: invoice2.id, result: "success")

    get "/api/v1/merchants/most_revenue?quantity=2"
    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.first["id"]).to eq(merchant1.id)
    expect(merchants.last["id"]).to eq(merchant2.id)
  end
end
