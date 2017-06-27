class CreateInvoicesItems < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices_items do |t|
      t.references :item, foreign_key: true
      t.references :invoice, foreign_key: true
      t.integer :quantity
      t.decimal :unit_price
    end
  end
end
