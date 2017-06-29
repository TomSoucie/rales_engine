class Transaction < ApplicationRecord

  # scope :successful -> {where(result: 'success')}
  # scope :unsuccessful -> {where(result: 'failed')}

  validates :credit_card_number, presence: true
  validates :credit_card_expiration_date, presence: false
  validates :result, presence: true
  validates :invoice_id, presence: true

  belongs_to :invoice

  def self.random
    offset = rand(Transaction.count)
    Transaction.offset(offset).first
  end
end
