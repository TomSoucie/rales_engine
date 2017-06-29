class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :unit_price, :merchant_id

  # has_many :invoice_items
  # has_many :invoices


  def unit_price
    sprintf('%.2f', (object.unit_price/100.0))
  end
end
