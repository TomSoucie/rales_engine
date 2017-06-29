require 'rails_helper'

describe "Transactions can be found from url params" do
  it "finds a single transaction by id" do
    transactions = create_list(:transaction, 3)
    id = transactions.first.id

    get "/api/v1/transactions/find?id=#{id}"

    expect(response).to be_success

    transaction = JSON.parse(response.body)

    expect(transaction).to have_key("id")
    expect(transaction["id"]).to be_a Integer
    expect(transaction["id"]).to eq(id)
  end

  it "finds a transaction by credit_card_number" do
    transactions = create_list(:transaction, 3)
    cc = transactions.first.credit_card_number

    get "/api/v1/transactions/find?credit_card_number=#{cc}"

    expect(response).to be_success

    transaction = JSON.parse(response.body)

    expect(transaction).to have_key("credit_card_number")
    expect(transaction["credit_card_number"]).to be_a String
    expect(transaction["credit_card_number"]).to eq(cc)
  end

  it "finds a transaction by credit_card_expiration_date" do
    transactions = create_list(:transaction, 3)
    cc_expiry = transactions.first.credit_card_expiration_date

    get "/api/v1/transactions/find?credit_card_expiration_date=#{cc_expiry}"

    expect(response).to be_success

    transaction = JSON.parse(response.body)

    # expect(transaction).to have_key("credit_card_expiration_date")
    # expect(transaction["credit_card_expiration_date"]).to be_a nil
    expect(transaction["credit_card_expiration_date"].to_s).to eq(cc_expiry)
  end

  it "finds a transaction by result" do
    transactions = create_list(:transaction, 3)
    first_result = transactions.first.result

    get "/api/v1/transactions/find?result=#{first_result}"

    expect(response).to be_success

    transaction = JSON.parse(response.body)

    expect(transaction).to have_key("result")
    expect(transaction["result"]).to be_a String
    expect(transaction["result"]).to eq(first_result)
  end


  it "finds a transaction by created_at" do
    raw_transaction = create(:transaction)
    create_time = raw_transaction.created_at

    get "/api/v1/transactions/find?created_at=#{create_time}"

    expect(response).to be_success

    transaction = JSON.parse(response.body)

    expect(transaction["id"]).to eq(raw_transaction.id)
  end

  it "finds a transaction by updated_at" do
    raw_transaction = create(:transaction)
    update_time = raw_transaction.updated_at

    get "/api/v1/transactions/find?updated_at=#{update_time}"

    expect(response).to be_success

    transaction = JSON.parse(response.body)

    expect(transaction["id"]).to eq(raw_transaction.id)
  end

  it "finds a transaction by invoice" do
    raw_transaction = create(:transaction)
    invoice = raw_transaction.invoice_id
    get "/api/v1/transactions/find?invoice_id=#{invoice}"

    expect(response).to be_success

    transaction = JSON.parse(response.body)

    expect(transaction).to have_key("invoice_id")
    expect(transaction["invoice_id"]).to be_a Integer
    expect(transaction["invoice_id"]).to eq(invoice)
  end

  it "finds a random transaction" do
    create_list(:transaction, 3)

    get "/api/v1/transactions/random"
    expect(response).to be_success

    transaction = JSON.parse(response.body)
    transaction_ids = Transaction.all.map { |m| m.id }

    expect(transaction_ids).to include(transaction["id"])
  end
end
