require 'rails_helper'

describe "GET total revenue on given date from all merchants" do
  it "returns the total revenue on x date from all merchants" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)

    today = Date.today

    item1 = create(:item, merchant_id: merchant1.id, unit_price: 1000)
    item2 = create(:item, merchant_id: merchant2.id, unit_price: 1000)
  end
end
