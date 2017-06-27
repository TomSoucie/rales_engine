require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_success

    merchants = JSON.parse(response.body)
    merchant = merchants.first

    expect(merchants.count).to eq(3)
    expect(merchant).to have_key("name")
    expect(merchant["name"]).to be_a String
  end
end
