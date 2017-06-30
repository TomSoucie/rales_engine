FactoryGirl.define do
  factory :invoice_item do
    item
    invoice
    quantity 1
    unit_price 1000
    created_at "Tue, 27 Mar 2012 14:53:59 UTC +00:00"
    updated_at "Tue, 27 Mar 2012 14:53:59 UTC +00:00"
  end
end
