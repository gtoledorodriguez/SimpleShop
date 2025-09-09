class CreateSales < ActiveRecord::Migration[8.0]
  def change
    create_table :sales do |t|
      t.integer :item_id
      t.integer :user_id
      t.integer :quanitity_sold
      t.float :total_price

      t.timestamps
    end
  end
end
