require 'rails_helper'

describe "Customers can be found from url params" do
  it "finds a single customer by id" do
    customers = create_list(:customer, 3)
    id = customers.first.id

    get "/api/v1/customers/find?id=#{id}"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer).to have_key("id")
    expect(customer["id"]).to be_a Integer
    expect(customer["id"]).to eq(id)
  end

  it "finds a customer by first_name" do
    customers = create_list(:customer, 3)
    name = customers.first.first_name

    get "/api/v1/customers/find?first_name=#{name}"
    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer).to have_key("first_name")
    expect(customer["first_name"]).to be_a String
    expect(customer["first_name"]).to eq(name)
  end

  it "finds a customer by last_name" do
    customers = create_list(:customer, 3)
    name = customers.first.last_name

    get "/api/v1/customers/find?last_name=#{name}"
    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer).to have_key("last_name")
    expect(customer["last_name"]).to be_a String
    expect(customer["last_name"]).to eq(name)
  end
  it "finds a random customer" do
    create_list(:customer, 3)

    get "/api/v1/customers/random"
    expect(response).to be_success

    customer = JSON.parse(response.body)
    customer_ids = Customer.all.map { |m| m.id }

    expect(customer_ids).to include(customer["id"])
  end

  it "finds a customer by created_at" do
    new_customer = create(:customer)
    create_time = new_customer.created_at

    get "/api/v1/customers/find?created_at=#{create_time}"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer["id"]).to eq(new_customer.id)
  end

  it "finds a customer by updated_at" do
    new_customer = create(:customer)
    update_time = new_customer.updated_at

    get "/api/v1/customers/find?updated_at=#{update_time}"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer["id"]).to eq(new_customer.id)
  end

  xit "finds all customers by id" do
    customers = create_list(:customer, 3)
    id = customers.first.id

    get "/api/v1/customers/find?id=#{id}"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer).to have_key("id")
    expect(customer["id"]).to be_a Integer
    expect(customer["id"]).to eq(id)
  end

  xit "finds all customers by first_name" do
    customers = create_list(:customer, 3)
    name = customers.first.first_name

    get "/api/v1/customers/find?first_name=#{name}"
    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer).to have_key("first_name")
    expect(customer["first_name"]).to be_a String
    expect(customer["first_name"]).to eq(name)
  end

  xit "finds all customers by last_name" do
    customers = create_list(:customer, 3)
    name = customers.first.last_name

    get "/api/v1/customers/find?last_name=#{name}"
    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer).to have_key("last_name")
    expect(customer["last_name"]).to be_a String
    expect(customer["last_name"]).to eq(name)
  end
end
