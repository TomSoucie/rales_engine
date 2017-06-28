require 'rails_helper'

describe "Customers API" do
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
