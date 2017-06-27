class ChangeUnitPriceTypeInItems < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :unit_price, :integer
  end
end
