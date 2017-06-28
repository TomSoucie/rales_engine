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
    it "finds one item by id" do
      raw_item = create(:item)

      get "/api/v1/items/find?id=#{raw_item.id}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["id"]).to eq(raw_item.id)
   end

    xit "finds one item by name, case-insensitve" do
      raw_item = create(:item)

      get "/api/v1/items/find?name=#{raw_item.name.upcase}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["name"]).to eq(raw_item.name)
    end

    xit "finds one item by description, case-insensitve" do
      raw_item = create(:item)

      get "/api/v1/items/find?description=#{raw_item.description.upcase}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["description"]).to eq(raw_item.description)
    end

   xit "finds one item by unit price" do
     raw_item = create(:item)

     get "/api/v1/items/find?unit_price=#{raw_item.unit_price}"

     item = JSON.parse(response.body)

     expected_price = "#{'%.2f' % (raw_item.unit_price/100.0)}"
     expect(response).to be_success
     expect(item["unit_price"]).to eq(expected_price)
   end

   it "finds one item by merchant" do
     raw_item = create(:item)

     get "/api/v1/items/find?merchant_id=#{raw_item.merchant.id}"

     item = JSON.parse(response.body)

     expect(response).to be_success
     expect(item["merchant_id"]).to eq(raw_item.merchant.id)
   end

   it "finds one item by date updated" do
     raw_item = create(:item)

     get "/api/v1/items/find?updated_at=#{raw_item.updated_at}"

     item = JSON.parse(response.body)

     expect(response).to be_success
     expect(item["id"]).to eq(raw_item.id)
   end

   it "finds one item by date created" do
     raw_item = create(:item)

     get "/api/v1/items/find?created_at=#{raw_item.created_at}"

     item = JSON.parse(response.body)

     expect(response).to be_success
     expect(item["id"]).to eq(raw_item.id)
   end

   it "finds random item" do
     create_list(:item, 2)

     get "/api/v1/items/random"

     raw_item = JSON.parse(response.body)
     raw_item_ids = Item.all.map { |item| item.id }

     expect(response).to be_success
     expect(raw_item_ids).to include(raw_item["id"])
   end

   it "finds all items by id" do
     raw_items = create_list(:item, 2)

     get "/api/v1/items/find_all?id=#{raw_items.first.id}"

     items = JSON.parse(response.body)

     expect(response).to be_success
     expect(items).to be_instance_of(Array)
     expect(items.first["id"]).to eq(raw_items.first.id)
   end

   xit "finds all items by name, case-insensitve" do
       create_list(:item, 2, name: "parachute")

       get "/api/v1/items/find_all?name=PARACHUTE"

       items = JSON.parse(response.body)

       expect(response).to be_success
       expect(items).to be_instance_of(Array)
       items.each do |item|
         expect(item["name"]).to eq("parachute")
       end
   end

   xit "finds all items by description, case-insensitve" do
       create_list(:item, 2, description: "It locks and unlocks.")

       get "/api/v1/items/find_all?description=IT LOCKS AND UNLOCKS."

       items = JSON.parse(response.body)

       expect(response).to be_success
       expect(items).to be_instance_of(Array)
       items.each do |item|
         expect(item["description"]).to eq("It locks and unlocks.")
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

   it "finds all items by merchant" do
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
