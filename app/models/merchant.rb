class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def self.top_x_merchants_revenue(amount)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .where(transactions: {result: 'success'})
      .order('revenue DESC')
      .group('merchants.id')
      .limit(amount)
  end

  def self.top_x_merchants_items(amount)
    select("merchants.*, SUM(invoice_items.quantity) AS most_items")
      .joins(invoices: [:invoice_items, :transactions])
      .where(transactions: {result: 'success'})
      .order('most_items DESC')
      .group('merchants.id')
      .limit(amount)
  end
end
