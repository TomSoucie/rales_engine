require 'rails_helper'

describe "It has URI-accessible relationships" do
  context "get to invoices/:id/invoice_items" do
    it "returns the associated invoice items" do
       new_invoice = create(:invoice)
       invoice_items = create_list(:invoice_item, 2, invoice_id: new_invoice.id)

       get "/api/v1/invoices/#{new_invoice.id}/invoice_items"
       invoice_item_collection = JSON.parse(response.body)

       expect(response).to be_success
       expect(invoice_item_collection).to be_instance_of(Array)
       expect(invoice_items_collection.count).to eq(2)

       invoice_item_collection.each do |invoice_item|
         expect(invoice_item["invoice_id"]).to eq(new_invoice.id)
       end
     end
   end

   context "get to invoices/:id/transactions" do
     xit "returns the associated transactions" do
       raw_merchant = create(:merchant)
       raw_item = create(:item, merchant_id: raw_merchant.id)

       get "/api/v1/items/#{raw_item.id}/merchant"
       merchant = JSON.parse(response.body)

       expect(response).to be_success
       expect(merchant).to be_instance_of(Hash)
       expect(merchant["id"]).to eq(raw_merchant.id)
     end
   end

   context "get to invoices/:id/items" do
     xit "returns the associated transactions" do

     end
   end

   context "get to invoices/:id/customer" do
     xit "returns the associated customer" do

     end
   end

   context "get to invoices/:id/merchant" do
     xit "returns the associated merchant" do

     end
   end
end
