require 'rails_helper'

describe "GET to /customers/:id/favorite_merchant" do
  it "returns the merchant where a customer has conducted the most successful transactions" do
    customer1 = create(:customer)

    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    customer1_invoices = create_list(:invoice, 2, customer_id: customer1.id, merchant_id: merchant1.id)
    customer2_invoice = create(:invoice, customer_id: customer1.id, merchant_id: merchant2.id)
    create(:transaction, invoice_id: customer2_invoice.id, result: "success")

    customer1_invoices.each do |invoice|
      create(:transaction, invoice_id: invoice.id, result: "success")
    end

    get "/api/v1/customers/#{customer1.id}/favorite_merchant"
    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant).to be_instance_of(Hash)
    expect(merchant["id"]).to eq(merchant1.id)
  end
end
