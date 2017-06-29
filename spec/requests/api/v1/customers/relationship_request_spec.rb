require 'rails_helper'

describe "Customers have relationships with invoices and transactions" do
  context "GET to customers/:id/invoices" do
    it "returns associated collection of invoices" do
      customer = create(:customer)
      invoices = create_list(:invoice, 2, merchant_id: merchant.id)

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
      items.each do |item|
        expect(item["merchant_id"]).to eq(merchant.id)
      end
    end
  end
end
