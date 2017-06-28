require 'rails_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
    create_list(:transaction, 5)

    get "/api/v1/transactions"

    expect(response).to be_success

    transactions = JSON.parse(response.body)
    transaction = transactions.first

    expect(transactions.count).to eq(5)

    expect(transaction).to have_key("invoice_id")
    expect(transaction["invoice_id"]).to be_a Integer

    expect(transaction).to have_key("credit_card_number")
    expect(transaction["credit_card_number"]).to be_a String

    expect(transaction).to have_key("result")
    expect(transaction["result"]).to be_a String
  end

  it "sends a single transaction" do
    transaction = create(:transaction)
    id = transaction.id

    get "/api/v1/transactions/#{transaction.id}"

    expect(response).to be_success

    raw_transaction = JSON.parse(response.body)

    expect(raw_transaction["id"]).to eq(id)

    expect(raw_transaction).to have_key("invoice_id")
    expect(raw_transaction["invoice_id"]).to be_a Integer

    expect(raw_transaction).to have_key("credit_card_number")
    expect(raw_transaction["credit_card_number"]).to be_a String
  end

  context "get to transactions/:id/invoice" do
    it "returns the associated invoice" do
     raw_invoice = create(:invoice)
     raw_transaction = create(:transaction, invoice_id: raw_invoice.id)

     get "/api/v1/transactions/#{raw_transaction.id}/invoice"
     invoice = JSON.parse(response.body)

     expect(response).to be_success
     expect(invoice).to be_instance_of(Hash)
     expect(invoice["id"]).to eq(raw_invoice.id)
   end
  end
end
