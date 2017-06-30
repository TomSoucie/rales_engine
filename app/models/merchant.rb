class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.random
    offset = rand(Merchant.count)
    Merchant.offset(offset).first
  end

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

  def self.revenue_on_date(date)
    sprintf('%.2f', ((Invoice.where(created_at: date)
      .joins(:invoice_items, :transactions)
      .where(transactions: {result: "success"})
      .sum("unit_price * quantity"))/100.0))
  end

  def revenue
    # binding.pry
    # invoice_items.sum("unit_price * quantity")
    # invoice_items.select
  end
end
