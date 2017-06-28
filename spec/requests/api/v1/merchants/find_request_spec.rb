require 'rails_helper'

describe "Merchants can be found from url params" do
  it "finds a single merchant by id" do
    merchants = create_list(:merchant, 3)
    id = merchants.first.id

    get "/api/v1/merchants/find?id=#{id}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant).to have_key("id")
    expect(merchant["id"]).to be_a Integer
    expect(merchant["id"]).to eq(id)
  end

  it "finds a merchant by name" do
    merchants = create_list(:merchant, 3)
    name = merchants.first.name

    get "/api/v1/merchants/find?name=#{name}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant).to have_key("name")
    expect(merchant["name"]).to be_a String
    expect(merchant["name"]).to eq(name)
  end

  it "finds a merchant by created_at" do
    raw_merchant = create(:merchant)
    create_time = raw_merchant.created_at

    get "/api/v1/merchants/find?created_at=#{create_time}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant["id"]).to eq(raw_merchant.id)
    # expect(merchant).to have_key("created_at")
    # expect(merchant["created_at"]).to be_a String
    # expect(merchant["created_at"]).to eq(create_time)
  end

  it "finds a merchant by updated_at" do
    raw_merchant = create(:merchant)
    update_time = raw_merchant.updated_at

    get "/api/v1/merchants/find?updated_at=#{update_time}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant["id"]).to eq(raw_merchant.id)

  end

  it "finds a random merchant" do
    create_list(:merchant, 3)
    # ids = merchants.map { |m| m.id }

    get "/api/v1/merchants/random"
    expect(response).to be_success

    merchant = JSON.parse(response.body)
    merchant_ids = Merchant.all.map { |m| m.id }

    expect(merchant_ids).to include(merchant["id"])    
  end
end
