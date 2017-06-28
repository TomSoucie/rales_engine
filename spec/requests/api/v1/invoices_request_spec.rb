require 'rails_helper'

describe "Invoices API" do
  context "GET /api/v1/invoices" do
    it "sends a list of invoices" do
      create_list(:invoice, 3)

      get "/api/v1/invoices"

      expect(response).to be_success

      invoices = JSON.parse(response.body)
      invoice = invoices.first

      expect(invoices.count).to eq(3)
      expect(invoice).to have_key("status")
      expect(invoice["status"]).to be_a String
      expect(invoice).to have_key("customer_id")
      expect(invoice["customer_id"]).to be_a Integer
    end
  end

  context "GET /api/v1/invoices/:id" do
    it "can get one invoice by its id" do
      id = create(:invoice).id

      get "/api/v1/invoices/#{id}"

      invoice = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(invoice["id"]).to eq(id)
      expect(invoice["status"]).to be_a String
    end
  end

  context "it can find invoices in many ways" do
    it "finds one invoice by id" do
      raw_invoice = create(:invoice)

      get "/api/v1/invoices/find?id=#{raw_invoice.id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["id"]).to eq(raw_invoice.id)
   end

    it "finds one invoice by status" do
      raw_invoice = create(:invoice)

      get "/api/v1/invoices/find?status=#{raw_invoice.status}"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["status"]).to eq(raw_invoice.status)
    end

   it "finds one invoice by merchant" do
     raw_invoice = create(:invoice)

     get "/api/v1/invoices/find?merchant_id=#{raw_invoice.merchant.id}"

     invoice = JSON.parse(response.body)

     expect(response).to be_success
     expect(invoice["merchant_id"]).to eq(raw_invoice.merchant.id)
   end

   it "finds one invoice by customer" do
     raw_invoice = create(:invoice)

     get "/api/v1/invoices/find?customer_id=#{raw_invoice.customer.id}"

     invoice = JSON.parse(response.body)

     expect(response).to be_success
     expect(invoice["customer_id"]).to eq(raw_invoice.customer.id)
   end

   it "finds one invoice by date updated" do
     raw_invoice = create(:invoice)

     get "/api/v1/invoices/find?updated_at=#{raw_invoice.updated_at}"

     invoice = JSON.parse(response.body)

     expect(response).to be_success
     expect(invoice["id"]).to eq(raw_invoice.id)
   end

   it "finds one invoice by date created" do
     raw_invoice = create(:invoice)

     get "/api/v1/invoices/find?created_at=#{raw_invoice.created_at}"

     invoice = JSON.parse(response.body)

     expect(response).to be_success
     expect(invoice["id"]).to eq(raw_invoice.id)
   end

   it "finds random invoice" do
     create_list(:invoice, 2)

     get "/api/v1/invoices/random"

     raw_invoice = JSON.parse(response.body)
     raw_invoice_ids = Invoice.all.map { |invoice| invoice.id }

     expect(response).to be_success
     expect(raw_invoice_ids).to include(raw_invoice["id"])
   end

   it "finds all invoices by id" do
     raw_invoices = create_list(:invoice, 2)

     get "/api/v1/invoices/find_all?id=#{raw_invoices.first.id}"

     invoices = JSON.parse(response.body)

     expect(response).to be_success
     expect(invoices).to be_instance_of(Array)
     expect(invoices.first["id"]).to eq(raw_invoices.first.id)
   end

   it "finds all invoices by status" do
       create_list(:invoice, 2, status: "shipped")

       get "/api/v1/invoices/find_all?status=shipped"

       invoices = JSON.parse(response.body)

       expect(response).to be_success
       expect(invoices).to be_instance_of(Array)
       invoices.each do |invoice|
         expect(invoice["status"]).to eq("shipped")
       end
   end

   it "finds all invoices by customer" do
       customer = create(:customer)
       create_list(:invoice, 2, customer: customer)

       get "/api/v1/invoices/find_all?customer_id=#{customer.id}"

       invoices = JSON.parse(response.body)

       expect(response).to be_success
       expect(invoices).to be_instance_of(Array)
       invoices.each do |invoice|
         expect(invoice["customer_id"]).to eq(customer.id)
       end
    end

    it "finds all invoices by merchant" do
       merchant = create(:merchant)
       create_list(:invoice, 2, merchant: merchant)

       get "/api/v1/invoices/find_all?merchant_id=#{merchant.id}"

       invoices = JSON.parse(response.body)

       expect(response).to be_success
       expect(invoices).to be_instance_of(Array)
       invoices.each do |invoice|
         expect(invoice["merchant_id"]).to eq(merchant.id)
       end
     end
   end
end
