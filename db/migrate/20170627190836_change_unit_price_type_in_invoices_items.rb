class ChangeUnitPriceTypeInInvoicesItems < ActiveRecord::Migration[5.1]
  def change
    change_column :invoices_items, :unit_price, :integer
  end
end
