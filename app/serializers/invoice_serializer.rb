class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :status, :customer_id, :merchant_id

  has_many :transactions
  has_many :invoice_items
  has_many :items
end
