class MerchantSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :items
  has_many :invoices
  has_many :customers

end
