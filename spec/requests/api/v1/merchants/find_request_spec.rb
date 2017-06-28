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

  xit "finds a merchant by updated_at" do
    merchants = create_list(:merchant, 3)
    update_time = merchants.first.updated_at

    get "/api/v1/merchants/find?updated_at=#{update_time}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant).to have_key("updated_at")
    expect(merchant["updated_at"]).to be_a String
    expect(merchant["updated_at"]).to eq(update_time)
  end

  context "GET to merchants/:id/invoices" do
    it "returns associated collection of invoices" do
      merchant = create(:merchant)
      invoices = create_list(:invoice, 2, merchant: merchant.id)

      get "/api/v1/merchants/#{merchant.id}/invoices"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices).to be_instance_of(Array)
      invoices.each do |invoice|
        expect(invoice["merchant_id"]).to eq(merchant.id)
      end
    end
  end

  context "GET to merchants/:id/items" do
    it "returns associated collection of items" do
      merchant = create(:merchant)

      items = create_list(:item, 2, merchant_id: merchant.id)

      get "/api/v1/merchants/#{merchant.id}/items"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items).to be_instance_of(Array)
      items.each do |i|
        expect(i["merchant_id"]).to eq(merchant.id)
      end
    end
  end
end
