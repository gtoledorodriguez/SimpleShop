class RenameQuanititySoldToQuantitySoldInSales < ActiveRecord::Migration[8.0]
  def change
    rename_column :sales, :quanitity_sold, :quantity_sold
  end
end
