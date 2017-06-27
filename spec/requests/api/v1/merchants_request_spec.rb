require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response).to be_success

    merchants = JSON.parse(response.body)
    merchant = merchants.first

    expect(merchants.count).to eq(3)
    expect(merchant).to have_key("name")
    expect(merchant["name"]).to be_a String
  end

  it "sends a single merchant" do
    merchant = create(:merchant)
    id = merchant.id

    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_success

    raw_merchant = JSON.parse(response.body)

    expect(raw_merchant["id"]).to eq(id)
    expect(raw_merchant).to have_key("name")
    expect(raw_merchant["name"]).to be_a String
  end
end

context "POST /api/v1/merchants" do
  it "creates a merchant with valid params" do
    merchant_params = {
      name: "Onnit"
    }
    expect {
      post "/api/v1/merchants", params: merchant_params
    }.to change {Merchant.count}.by(1)

    expect(response).to be_success
    expect(response).to have_http_status(200)
  end
end
