require 'rails_helper'

describe "GET request to items with /most_items" do
  it "returns the top x items ranked by total items sold" do
    item1 = create(:item)
    item2 = create(:item)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
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

    get "/api/v1/items/most_items?quantity=2"
    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.first["id"]).to eq(item1.id)
    expect(items.last["id"]).to eq(item2.id)
  end
end
