require 'rails_helper'

describe "Customers have relationships with invoices and transactions" do
  context "GET to customers/:id/invoices" do
    it "returns associated collection of invoices" do
      customer = create(:customer)
      invoices = create_list(:invoice, 2, customer_id: customer.id)

      get "/api/v1/customers/#{customer.id}/invoices"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices).to be_instance_of(Array)
      invoices.each do |invoice|
        expect(invoice["customer_id"]).to eq(customer.id)
      end
    end
  end

  context "GET to customers/:id/transactions" do
    it "returns associated collection of transactions" do
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id)
      transactions = create_list(:transaction, 2, invoice_id: invoice.id)

      get "/api/v1/customers/#{customer.id}/transactions"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions).to be_instance_of(Array)
      expect(transactions.count).to eq(2)
      transactions.each do |t|
        expect(t["invoice_id"]).to eq(invoice.id)
      end
    end
  end
end
