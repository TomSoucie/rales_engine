require 'rails_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
    create_list(:transactions, 5)

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
end
