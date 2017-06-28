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
  
  context "GET to customers/:id/invoices" do
    it "returns associated collection of invoices" do
      raw_customer = create(:customer)
      raw_invoices = create_list(:invoice, 2, customer_id: raw_customer.id)

      get "/api/v1/customers/#{raw_customer.id}/invoices"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices).to be_instance_of(Array)
      invoices.each do |invoice|
        expect(invoice["customer_id"]).to eq(raw_customer.id)
      end
    end
  end

  context "GET to customers/:id/transactions" do
    it "returns associated collection of transactions" do
      raw_customer = create(:customer)
      raw_invoice = create(:invoice, customer_id: raw_customer.id)
      raw_transactions = create_list(:transaction, 2, invoice_id: raw_invoice.id)

      get "/api/v1/customers/#{raw_customer.id}/transactions"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions).to be_instance_of(Array)
      transactions.each do |transaction|
        expect(transaction["invoice_id"]).to eq(raw_invoice.id)
      end
    end
  end
end
