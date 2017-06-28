require 'rails_helper'

describe "Invoice-Items API" do
  context "GET /api/v1/invoice_items" do
    it "sends a list of invoice/items" do
      create_list(:invoice_item, 3)

      get "/api/v1/invoice_items"

      expect(response).to have_http_status(200)

      invoice_items = JSON.parse(response.body)
      invoice_item = invoice_items.first
# binding.pry
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

  context "it can find invoice items in many ways" do
    it "finds one invoice item by id" do
      raw_invoice_item = create(:invoice_item)

      get "/api/v1/invoice_items/find?id=#{raw_invoice_item.id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item["id"]).to eq(raw_invoice_item.id)
   end

   it "finds one invoice item by unit price" do
     raw_invoice_item = create(:invoice_item)

     get "/api/v1/invoice_items/find?unit_price=#{raw_invoice_item.unit_price}"

     invoice_item = JSON.parse(response.body)

     expected_price = "#{sprintf('%.2f', (raw_invoice_item.unit_price/100))}"
     expect(response).to be_success
     expect(invoice_item["unit_price"]).to eq(expected_price)
   end

   it "finds one invoice item by item" do
     raw_invoice_item = create(:invoice_item)

     get "/api/v1/invoice_items/find?item_id=#{raw_invoice_item.item.id}"

     invoice_item = JSON.parse(response.body)

     expect(response).to be_success
     expect(invoice_item["item_id"]).to eq(raw_invoice_item.item.id)
   end

   it "finds one invoice item by invoice" do
     raw_invoice_item = create(:invoice_item)

     get "/api/v1/invoice_items/find?invoice_id=#{raw_invoice_item.invoice.id}"

     invoice_item = JSON.parse(response.body)

     expect(response).to be_success
     expect(invoice_item["invoice_id"]).to eq(raw_invoice_item.invoice.id)
   end

   it "finds one invoice item by date updated" do
     raw_invoice_item = create(:invoice_item)

     get "/api/v1/invoice_items/find?updated_at=#{raw_invoice_item.updated_at}"

     invoice_item = JSON.parse(response.body)

     expect(response).to be_success
     expect(invoice_item["id"]).to eq(raw_invoice_item.id)
   end

   it "finds one invoice item by date created" do
     raw_invoice_item = create(:invoice_item)

     get "/api/v1/invoice_items/find?created_at=#{raw_invoice_item.created_at}"

     invoice_item = JSON.parse(response.body)

     expect(response).to be_success
     expect(invoice_item["id"]).to eq(raw_invoice_item.id)
   end

   it "finds one invoice item by quantity" do
     raw_invoice_item = create(:invoice_item)

     get "/api/v1/invoice_items/find?quantity=#{raw_invoice_item.quantity}"

     invoice_item = JSON.parse(response.body)

     expect(response).to be_success
     expect(invoice_item["id"]).to eq(raw_invoice_item.id)
   end

   it "finds a random invoice item" do
    create_list(:invoice_item, 2)

    get "/api/v1/invoice_items/random"

    invoice_item = JSON.parse(response.body)

    invoice_item_ids = InvoiceItem.all.map { |invoice_item| invoice_item.id }

    expect(response).to be_success
    expect(invoice_item_ids).to include(invoice_item["id"])
  end

   it "finds all invoice items by id" do
     raw_invoice_items = create_list(:invoice_item, 2)

     get "/api/v1/invoice_items/find_all?id=#{raw_invoice_items.first.id}"

     invoice_items = JSON.parse(response.body)

     expect(response).to be_success
     expect(invoice_items).to be_instance_of(Array)
     expect(invoice_items.first["id"]).to eq(raw_invoice_items.first.id)
   end

   it "finds all invoice items by quantity" do
     raw_invoice_items = create_list(:invoice_item, 2)

     get "/api/v1/invoice_items/find_all?quantity=#{raw_invoice_items.first.quantity}"

     invoice_items = JSON.parse(response.body)

     expect(response).to be_success
     expect(invoice_items).to be_instance_of(Array)
     expect(invoice_items.first["quantity"]).to eq(raw_invoice_items.first.quantity)
   end

   it "finds all invoice items by unit price" do
       create_list(:invoice_item, 2, unit_price: 1000)

       get "/api/v1/invoice_items/find_all?unit_price=1000"

       invoice_items = JSON.parse(response.body)

       expect(response).to be_success
       expect(invoice_items).to be_instance_of(Array)
       invoice_items.each do |invoice_item|
         expect(invoice_item["unit_price"]).to eq("10.00")
       end
   end

   it "finds all invoice items by item" do
       item = create(:item)
       create_list(:invoice_item, 2, item: item)

       get "/api/v1/invoice_items/find_all?item_id=#{item.id}"

       invoice_items = JSON.parse(response.body)

       expect(response).to be_success
       expect(invoice_items).to be_instance_of(Array)
       invoice_items.each do |invoice_item|
         expect(invoice_item["item_id"]).to eq(item.id)
       end
    end

   it "finds all invoice items by invoice" do
       invoice = create(:invoice)
       create_list(:invoice_item, 2, invoice: invoice)

       get "/api/v1/invoice_items/find_all?invoice_id=#{invoice.id}"

       invoice_items = JSON.parse(response.body)

       expect(response).to be_success
       expect(invoice_items).to be_instance_of(Array)
       invoice_items.each do |invoice_item|
         expect(invoice_item["invoice_id"]).to eq(invoice.id)
       end
    end
  end
end
