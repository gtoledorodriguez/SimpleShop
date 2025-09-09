class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.integer :business_id
      t.string :name
      t.float :price
      t.integer :quantity_in_stock
      t.integer :low_stock_threshold
      t.integer :sales_count

      t.timestamps
    end
  end
end
