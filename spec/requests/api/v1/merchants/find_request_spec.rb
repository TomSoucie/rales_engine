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

    get "/api/v1/merchants/random"
    expect(response).to be_success

    merchant = JSON.parse(response.body)
    merchant_ids = Merchant.all.map { |m| m.id }

    expect(merchant_ids).to include(merchant["id"])
  end

  it "finds all merchants by id" do
    new_merchants = create_list(:merchant, 3)
    id = new_merchants.first.id

    get "/api/v1/merchants/find_all?id=#{id}"

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants).to be_a Array
    expect(merchants.first["id"]).to eq(id)
  end

  it "finds all merchants by name" do
    new_merchants = create_list(:merchant, 3)
    name = new_merchants.first.name

    get "/api/v1/merchants/find_all?name=#{name}"

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants).to be_a Array
    expect(merchants.first["name"]).to eq(name)
  end

  it "finds all merchants by created_at" do
    new_merchants = create_list(:merchant, 3)
    create_time = new_merchants.first.created_at

    get "/api/v1/merchants/find_all?created_at=#{create_time}"

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants).to be_a Array
    expect(merchants.first["id"]).to eq(new_merchants.first.id)
  end

  it "finds all merchants by updated_at" do
    new_merchants = create_list(:merchant, 3)
    update_time = new_merchants.first.updated_at

    get "/api/v1/merchants/find_all?updated_at=#{update_time}"

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants).to be_a Array
    expect(merchants.first["id"]).to eq(new_merchants.first.id)
  end
end
