class CreateBusinesses < ActiveRecord::Migration[8.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.integer :owner_id
      t.integer :items_count

      t.timestamps
    end
  end
end
