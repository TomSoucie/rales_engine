FactoryGirl.define do
  factory :transaction do
    # invoice nil
    credit_card_number "12345678"
    credit_card_expiration_date ""
    result "Paid"
  end

  invoice
end
