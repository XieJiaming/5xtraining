class AddProductResolve < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :product_resolve, :integer, :default => 0
  end
end
