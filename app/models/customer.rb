class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices
  has_many :items, through: :invoices

  def self.random
    offset = rand(Customer.count)
    Customer.offset(offset).first
  end
end
