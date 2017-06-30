require 'rails_helper'

describe "GET total revenue on given date from all merchants" do
  it "returns the total revenue on x date from all merchants" do
    # merchant1 = create(:merchant)
    # merchant2 = create(:merchant)
    # item1 = create(:item)
    # item2 = create(:item)
    # today = Date.today
    #
    # invoice1 = create(:invoice, merchant_id: merchant1.id, created_at: today)
    # transaction1 = create(:transaction, invoice_id: invoice1.id)
    #
    # invoice2 = create(:invoice, merchant_id: merchant2.id, created_at: today)
    # transaction2 = create(:transaction, invoice_id: invoice2.id)
    #
    # invoice_item1 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id)
    # invoice_item2 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
    #
    # get "/api/v1/merchants/revenue?date=#{today}"
    #
    # revenue = JSON.parse(response.body)
    #
    # expect(response).to be_success
    # expect(revenue).to eq({ "total_revenue" => "10000.15" })

    date = "2012-03-16 11:55:05"
    merchant = create(:merchant)
    invoices = create_list(:invoice, 2,
                            created_at: date,
                            merchant_id: merchant.id)

    invoices.each do |invoice|
      create(:transaction,
              invoice_id: invoice.id,
              result: "success")
      create(:invoice_item,
              invoice_id: invoice.id,
              unit_price: 1000,
              quantity: 2)
    end

    get "/api/v1/merchants/revenue?date=#{date}"
    revenue = JSON.parse(response.body)

    expected_return = {"total_revenue" => "40.00"}
    expect(response).to be_success
    expect(revenue).to eq({"total_revenue" => "40.00"})
  end
end
