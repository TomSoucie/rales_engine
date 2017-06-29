require 'rails_helper'

describe "It has URI-accessible relationships" do
  context "get to invoices/:id/invoice_items" do
    it "returns the associated invoice items" do
       raw_item = create(:item)
       invoice_item = create_list(:invoice_item, 2, item_id: raw_item.id)

       get "/api/v1/items/#{raw_item.id}/invoice_items"
       invoice_items = JSON.parse(response.body)

       expect(response).to be_success
       expect(invoice_items).to be_instance_of(Array)
       expect(invoice_items.count).to eq(2)

       invoice_items.each do |invoice_item|
         expect(invoice_item["item_id"]).to eq(raw_item.id)
       end
     end
   end

   context "get to items/:id/merchant" do
     it "returns the associated merchant" do
       raw_merchant = create(:merchant)
       raw_item = create(:item, merchant_id: raw_merchant.id)

       get "/api/v1/items/#{raw_item.id}/merchant"
       merchant = JSON.parse(response.body)

       expect(response).to be_success
       expect(merchant).to be_instance_of(Hash)
       expect(merchant["id"]).to eq(raw_merchant.id)
     end
   end
end
