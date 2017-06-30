class Item < ApplicationRecord

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.random
    offset = rand(Item.count)
    Item.offset(offset).first
  end

  def self.top_x_items_revenue(amount)
    select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .where(transactions: {result: 'success'})
      .order('revenue DESC')
      .group('items.id')
      .limit(amount)
  end

  def self.top_x_items_sold(amount)
    joins(:invoices)
    .merge(Invoice.successful)
    .group(:id)
    .order("sum(invoice_items.quantity) DESC")
    .first(amount)
  end

  def best_day
    {"best_day" => invoices
     .joins(:invoice_items)
     .group(:id)
     .group(:created_at)
     .order("sum(invoice_items.quantity) DESC")
     .first
     .created_at}
  end
end
