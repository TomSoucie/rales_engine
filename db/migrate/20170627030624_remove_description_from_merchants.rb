class RemoveDescriptionFromMerchants < ActiveRecord::Migration[5.1]
  def change
    remove_column :merchants, :description, :text
  end
end
