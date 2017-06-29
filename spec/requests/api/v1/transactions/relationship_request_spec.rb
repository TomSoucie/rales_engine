require 'rails_helper'

describe "Transactions have a relationship to an invoice" do
  context "GET to transactions/:id/invoice" do
    it "returns the invoice related to the transaction" do
      # invoice = create(:invoice)
      transaction = create(:transaction)
      id = transaction.id
      invoice_id = transaction.invoice_id

      get "/api/v1/transactions/#{id}/invoice"
      expect(response).to be_success

      invoice = JSON.parse(response.body)

      expect(invoice["id"]).to eq(invoice_id)
      expect(invoice["id"]).to be_a Integer
      # expect(invoice_transaction["invoice_id"]).to eq(invoice_id)
      # expect(invoice_transaction["invoice_id"]).to be_a Integer


    end
  end
end
