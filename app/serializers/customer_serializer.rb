class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name

  has_many :invoices
  has_many :transactions
end
