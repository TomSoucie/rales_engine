require 'rails_helper'

describe "GET request for the best day for one item" do
  it "returns the date with the most sales for an item" do
    item1 = create(:item)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    invoice_item1 = create(:invoice_item,
                           item_id: item1.id,
                           invoice_id: invoice1.id,
                           quantity: 3)
    invoice_item2 = create(:invoice_item,
                           item_id: item1.id,
                           invoice_id: invoice2.id,
                           quantity: 1)

    get "/api/v1/items/#{item1.id}/best_day"
    date = JSON.parse(response.body)
    proposed_date = invoice1.created_at.to_i
    actual_date = DateTime.parse(date["best_day"].to_i)

    expect(response).to be_success
    expect(date).to be_instance_of(Hash)
    expect(proposed_date).to eq(actual_date)
  end
end
