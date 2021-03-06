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
       new_invoice = create(:invoice)
       new_items = create_list(:item, 2)
       new_invoice_item1 = create(:invoice_item, invoice_id: new_invoice.id, item_id: new_items.first.id)
       new_invoice_item2 = create(:invoice_item, invoice_id: new_invoice.id, item_id: new_items.last.id)

       get "/api/v1/invoices/#{new_invoice.id}/items"
       expect(response).to be_success

       item_collection = JSON.parse(response.body)

       expected_new_item_ids = new_items.map do |new_item|
         new_item.id
       end
     end
   end

   context "get to invoices/:id/customer" do
     it "returns the associated customer" do
       new_customer = create(:customer)
       new_invoice = create(:invoice, customer_id: new_customer.id)

       get "/api/v1/invoices/#{new_invoice.id}/customer"
       expect(response).to be_success

       customer = JSON.parse(response.body)

       expect(customer).to be_a Hash
       expect(customer["id"]).to eq(new_customer.id)
     end
   end

   context "get to invoices/:id/merchant" do
     it "returns the associated merchant" do
       new_merchant = create(:merchant)
       new_invoice = create(:invoice, merchant_id: new_merchant.id)

       get "/api/v1/invoices/#{new_invoice.id}/merchant"
       expect(response).to be_success

       merchant = JSON.parse(response.body)

       expect(merchant).to be_a Hash
       expect(merchant["id"]).to eq(new_merchant.id)
     end
   end
end
