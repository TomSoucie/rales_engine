require 'rails_helper'

describe "Invoices API" do
  context "GET /api/v1/invoices" do
    it "sends a list of invoices" do
      create_list(:invoice, 3)

      get "/api/v1/invoices"

      expect(response).to have_http_status(200)

      invoices = JSON.parse(response.body)
      invoice = invoices.first

      expect(invoices.count).to eq(3)
      expect(invoice).to have_key("status")
      expect(item["status"]).to be_a String
      expect(invoice).to have_key("customer_id")
      expect(item["customer_id"]).to be_a String
    end
  end

  context "GET /api/v1/invoices/:id" do
    it "can get one invoice by its id" do
      id = create(:invoice).id

      get "api/v1/invoices/#{id}"

      item = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(item["id"]).to eq(id)
      expect(item["status"]).to be_a String
    end
  end
end
