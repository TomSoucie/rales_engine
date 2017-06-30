require 'rails_helper'

describe "Invoice-Items API" do
  context "GET /api/v1/invoice_items" do
    it "sends a list of invoice/items" do
      create_list(:invoice_item, 3)

      get "/api/v1/invoice_items"

      expect(response).to have_http_status(200)

      invoice_items = JSON.parse(response.body)
      invoice_item = invoice_items.first

      expect(invoice_items.count).to eq(3)
      expect(invoice_item).to have_key("quantity")
      expect(invoice_item["quantity"]).to be_a Integer
      expect(invoice_item).to have_key("unit_price")
      expect(invoice_item["unit_price"]).to be_a String
    end
  end

  context "GET /api/v1/invoices_items/:id" do
    it "can get one invoice/item by its id" do
      id = create(:invoice_item).id

      get "/api/v1/invoice_items/#{id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(invoice_item["id"]).to eq(id)
      expect(invoice_item["quantity"]).to be_a Integer
      expect(invoice_item["unit_price"]).to be_a String
    end
  end
end
