class AddValidateToProduct < ActiveRecord::Migration[6.1]
  def change
    change_column_null :products, :price, false
  end
end
