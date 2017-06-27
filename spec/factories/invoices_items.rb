FactoryGirl.define do
  factory :invoices_item do
    item
    invoice
    quantity 1
    unit_price 10.50
  end
end
