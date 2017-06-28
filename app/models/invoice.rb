class Invoice < ApplicationRecord

  validates :customer_id, presence: true
  validates :merchant_id, presence: true
  validates :status, presence: true

  belongs_to :customer
  belongs_to :merchant

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.most_expensive(limit = 5)
    select("invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
      .joins(:invoice_items, :transactions).where(transactions: {result: "success"})
      .group("invoices.id")
      .order("total_revenue DESC")
      .limit(limit)
  end

  # def self.most_expensive(limit = 5)
  #   select("invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
  #     .joins(:invoice_items, :transactions)
  #     # .where(transactions: {result: "success"})
  #     .merge(Transaction.successful) #need to establish scope in Transaction
  #     .group("invoices.id")
  #     .order("total_revenue DESC")
  #     .limit(limit)
  # end

  def self.random
    offset = rand(Invoice.count)
    Invoice.offset(offset).first
  end

end
