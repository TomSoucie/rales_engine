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
    it "can get one item by its id" do
      id = create(:item).id

      get "/api/v1/items/#{id}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["id"]).to eq(id)
      expect(item["name"]).to be_a String
      expect(item["description"]).to be_a String
    end
  end
end
