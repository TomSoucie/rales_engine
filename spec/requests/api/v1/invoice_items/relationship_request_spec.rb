require 'rails_helper'

describe "It has URI-accessible relationships" do
  context "get to invoice_items/:id/invoice" do
    it "returns the associated invoice" do
      raw_invoice = create(:invoice)
      invoice_item = create(:invoice_item, invoice_id: raw_invoice.id)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"
      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice).to be_instance_of(Hash)
      expect(invoice["id"]).to eq(raw_invoice.id)
    end
   end

  context "get to invoice_items/:id/item" do
    it "returns the associated item" do
      raw_item = create(:item)
      invoice_item = create(:invoice_item, item_id: raw_item.id)

      get "/api/v1/invoice_items/#{invoice_item.id}/item"
      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item).to be_instance_of(Hash)
      expect(item["id"]).to eq(raw_item.id)
    end
  end
end
