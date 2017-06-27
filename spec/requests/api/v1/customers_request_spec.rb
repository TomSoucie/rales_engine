require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get "/api/v1/customers"

    expect(response).to be_success

    customers = JSON.parse(response.body)
    customer = customers.first

    expect(customers.count).to eq(3)
    expect(customer).to have_key("first_name")
    expect(customer["first_name"]).to be_a String

    expect(customer).to have_key("last_name")
    expect(customer["last_name"]).to be_a String
  end

  it "sends a single customer" do
    customer = create(:customer)
    id = customer.id

    get "/api/v1/customers/#{customer.id}"

    expect(response).to be_success

    raw_customer = JSON.parse(response.body)

    expect(raw_customer["id"]).to eq(id)
    expect(raw_customer).to have_key("first_name")
    expect(raw_customer["first_name"]).to be_a String
    expect(raw_customer).to have_key("last_name")
    expect(raw_customer["last_name"]).to be_a String
  end
end
