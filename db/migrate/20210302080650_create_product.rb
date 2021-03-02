class CreateProduct < ActiveRecord::Migration[6.1]
  def change
    create_table :product do |t|
      t.string :name, null: false
      t.integer :price
      t.integer :stock, default: 0

      t.timestamps
    end
  end
end
