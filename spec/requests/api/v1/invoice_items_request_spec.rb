require 'rails_helper'

describe "Invoice-Items API" do
  context "GET /api/v1/invoices_items" do
    it "sends a list of invoices/items" do
      create_list(:invoice_item, 3)

      get "/api/v1/invoices_items"

      expect(response).to have_http_status(200)

      invoices_items = JSON.parse(response.body)
      invoices_item = invoices_items.first

      expect(invoices_items.count).to eq(3)
      expect(invoices_item).to have_key("quantity")
      expect(invoices_item["quantity"]).to be_a String
      expect(invoices_item).to have_key("unit_price")
      expect(invoices_item["unit_price"]).to be_a String
    end
  end

  context "GET /api/v1/invoices_items/:id" do
    it "can get one invoice/item by its id" do
      id = create(:invoice_item).id

      get "/api/v1/invoice_items/#{id}"

      invoices_item = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(invoices_item["id"]).to eq(id)
      expect(invoices_item["quantity"]).to be_a String
      expect(invoices_item["unit_price"]).to be_a Integer
    end
  end
end
