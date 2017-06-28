require 'rails_helper'

describe "Merchant url params returns single merchant" do
  it "find a single merchant from list" do
    merchants = create_list(:merchant, 3)
    id = merchants.first.id

    get "/api/v1/merchants/find?id=#{id}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant).to have_key("id")
    expect(merchant["id"]).to be_a Integer
    expect(merchant["id"]).to eq(id)
  end

  xit "finds a merchant by name" do
    merchants = create_list(:merchant, 3)
    name = merchants.first.name

    get "/api/v1/merchants/find?name=#{name}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant).to have_key("name")
    expect(merchant["name"]).to be_a String
    expect(merchant["name"]).to eq(name)
  end

  xit "finds a merchant by created_at" do
    merchants = create_list(:merchant, 3)
    create_time = merchants.first.created_at

    get "/api/v1/merchants/find?created_at=#{create_time}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant).to have_key("created_at")
    expect(merchant["created_at"]).to be_a String
    expect(merchant["created_at"]).to eq(create_time)    
  end
end
