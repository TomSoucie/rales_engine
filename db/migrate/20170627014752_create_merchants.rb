class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.text :name
      t.text :description 

      t.timestamps
    end
  end
end
