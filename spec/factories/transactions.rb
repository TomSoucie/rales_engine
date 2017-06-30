FactoryGirl.define do
  factory :transaction do
    invoice
    credit_card_number "12345678"
    credit_card_expiration_date ""
    result "success"
    created_at "Tue, 27 Mar 2012 14:53:59 UTC +00:00"
    updated_at "Tue, 27 Mar 2012 14:53:59 UTC +00:00"
  end
end
