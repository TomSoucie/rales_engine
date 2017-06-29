require 'rails_helper'

describe "It has URI-accessible relationships" do
  context "get to invoices/:id/invoice_items" do
    it "returns the associated invoice items" do
       new_invoice = create(:invoice)
       invoice_items = create_list(:invoice_item, 2, invoice_id: new_invoice.id)

       get "/api/v1/invoices/#{new_invoice.id}/invoice_items"
       expect(response).to be_success

       invoice_item_collection = JSON.parse(response.body)

       expect(invoice_item_collection).to be_a Array
       expect(invoice_item_collection.count).to eq(2)

       invoice_item_collection.each do |invoice_item|
         expect(invoice_item["invoice_id"]).to eq(new_invoice.id)
       end
     end
   end

   context "get to invoices/:id/transactions" do
     it "returns the associated transactions" do
       new_invoice = create(:invoice)
       transactions = create_list(:transaction, 2, invoice_id: new_invoice.id)

       get "/api/v1/invoices/#{new_invoice.id}/transactions"
       expect(response).to be_success

       transaction_collection = JSON.parse(response.body)

       expect(transaction_collection).to be_a Array
       expect(transaction_collection.count).to eq(2)

       transaction_collection.each do |t|
         expect(t["invoice_id"]).to eq(new_invoice.id)
       end
     end
   end

   context "get to invoices/:id/items" do
     it "returns the associated items" do
       new_merchant = create(:merchant)
       new_invoice = create(:invoice, merchant_id: new_merchant.id)
       item = create_list(:item, 2, merchant_id: new_merchant.id)

       get "/api/v1/invoices/#{new_invoice.id}/items"
       expect(response).to be_success

       item_collection = JSON.parse(response.body)

       expect(item_collection).to be_a Array
       binding.pry
       expect(item_collection.count).to eq(2)

       items_collection.each do |ic|
         expect(ic["merchant_id"]).to eq(new_invoice.merchant_id)
       end
     end
   end

   context "get to invoices/:id/customer" do
     xit "returns the associated customer" do
       new_customer = create(:customer)
       new_invoice = create(:invoice, customer_id: new_customer.id)

       get "/api/v1/invoices/#{new_invoice.id}/customer"
       expect(response).to be_success

       customer = JSON.parse(response.body)

       expect(customer)
     end
   end

   context "get to invoices/:id/merchant" do
     xit "returns the associated merchant" do

     end
   end
end
