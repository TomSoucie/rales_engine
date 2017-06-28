require 'rails_helper'

describe "Items API" do
  context "GET /api/v1/items" do
    it "sends a list of items" do
      create_list(:item, 3)

      get "/api/v1/items"

      expect(response).to have_http_status(200)

      items = JSON.parse(response.body)
      item = items.first

      expect(items.count).to eq(3)
      expect(item).to have_key("name")
      expect(item["name"]).to be_a String
      expect(item).to have_key("description")
      expect(item["description"]).to be_a String
    end
  end

  context "GET /api/v1/items/:id" do
    it "can GET one item by its id" do
      id = create(:item).id

      get "/api/v1/items/#{id}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["id"]).to eq(id)
      expect(item["name"]).to be_a String
      expect(item["description"]).to be_a String
    end
  end

  context "it can find items in many ways" do
     xit "finds one item by id" do
     raw_item = create(:item)

     get "/api/v1/items/find?id=#{raw_item.id}"

     item = JSON.parse(response.body)

     expect(response).to be_success
     expect(item["id"]).to eq(raw_item.id)
   end

   xit "finds one item by name, case-insensitve" do
     new_item = create(:item)

     get "/api/v1/items/find?name=#{new_item.name.upcase}"

     item = JSON.parse(response.body)

     expect(response).to be_success
     expect(item["name"]).to eq(new_item.name)
   end

   xit "finds one item by description, case-insensitve" do
     new_item = create(:item)

     get "/api/v1/items/find?description=#{new_item.description.upcase}"

     item = JSON.parse(response.body)

     expect(response).to be_success
     expect(item["description"]).to eq(new_item.description)
   end

   xit "finds one item by unit price" do
     new_item = create(:item)

     get "/api/v1/items/find?unit_price=#{new_item.unit_price}"

     item = JSON.parse(response.body)

     expected_price = "#{'%.2f' % (new_item.unit_price/100.0)}"
     expect(response).to be_success
     expect(item["unit_price"]).to eq(expected_price)
   end

   xit "finds one item by merchant" do
     new_item = create(:item)

     get "/api/v1/items/find?merchant_id=#{new_item.merchant.id}"

     item = JSON.parse(response.body)

     expect(response).to be_success
     expect(item["merchant_id"]).to eq(new_item.merchant.id)
   end

   xit "finds one item by date updated" do
     new_item = create(:item)

     get "/api/v1/items/find?updated_at=#{new_item.updated_at}"

     item = JSON.parse(response.body)

     expect(response).to be_success
     expect(item["id"]).to eq(new_item.id)
   end

   xit "finds one item by date created" do
     new_item = create(:item)

     get "/api/v1/items/find?created_at=#{new_item.created_at}"

     item = JSON.parse(response.body)

     expect(response).to be_success
     expect(item["id"]).to eq(new_item.id)
   end

   xit "finds random item" do
     create_list(:item, 2)

     get "/api/v1/items/random"

     item = JSON.parse(response.body)
     item_ids = Item.all.map { |item| item.id }

     expect(response).to be_success
     expect(item_ids).to include(item["id"])
   end

   xit "finds all items by id" do
     new_items = create_list(:item, 2)

     get "/api/v1/items/find_all?id=#{new_items.first.id}"

     items = JSON.parse(response.body)

     expect(response).to be_success
     expect(items).to be_instance_of(Array)
     expect(items.first["id"]).to eq(new_items.first.id)
   end

   xit "finds all items by name, case-insensitve" do
     create_list(:item, 2, name: "thingy")

     get "/api/v1/items/find_all?name=THINGY"

     items = JSON.parse(response.body)

     expect(response).to be_success
     expect(items).to be_instance_of(Array)
     items.each do |item|
       expect(item["name"]).to eq("thingy")
     end
   end

   xit "finds all items by description, case-insensitve" do
     create_list(:item, 2, description: "This thingy is huge.")

     get "/api/v1/items/find_all?description=THIS THINGY IS HUGE."

     items = JSON.parse(response.body)

     expect(response).to be_success
     expect(items).to be_instance_of(Array)
     items.each do |item|
       expect(item["description"]).to eq("This thingy is huge.")
     end
   end

   xit "finds all items by unit price" do
     create_list(:item, 2, unit_price: 1000)

     get "/api/v1/items/find_all?unit_price=1000"

     items = JSON.parse(response.body)

     expect(response).to be_success
     expect(items).to be_instance_of(Array)
     items.each do |item|
       expect(item["unit_price"]).to eq("10.00")
     end
   end

   xit "finds all items by merchant" do
     merchant = create(:merchant)
     create_list(:item, 2, merchant: merchant)
     get "/api/v1/items/find_all?merchant_id=#{merchant.id}"
     items = JSON.parse(response.body)

     expect(response).to be_success
     expect(items).to be_instance_of(Array)
     items.each do |item|
       expect(item["merchant_id"]).to eq(merchant.id)
     end
   end
  end
end
