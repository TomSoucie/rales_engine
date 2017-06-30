require 'csv'

namespace :csv_handler do
  desc "Import customers.csv data"
  task customers: :environment do
    csv_text = File.read('./lib/data/customers.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Customer.create!(row.to_hash)
    end
  end

  desc "Import merchants.csv data"
  task merchants: :environment do
    csv_text = File.read('./lib/data/merchants.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Merchant.create!(row.to_hash)
    end
  end

  desc "Import invoices.csv data"
  task invoices: :environment do
    csv_text = File.read('./lib/data/invoices.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Invoice.create!(row.to_hash)
    end
  end

  desc "Import items.csv data"
  task items: :environment do
    csv_text = File.read('./lib/data/items.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Item.create!(row.to_hash)
    end
  end

  desc "Import invoice_items.csv data"
  task invoice_items: :environment do
    csv_text = File.read('./lib/data/invoice_items.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end

  desc "Import transactions.csv data"
  task transactions: :environment do
    csv_text = File.read('./lib/data/transactions.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Transaction.create!(row.to_hash)
    end
  end

  desc "Execute all existing tasks"
  task all: [:customers, :merchants, :invoices, :items, :invoice_items, :transactions ]
  
end
