class RenameProductName < ActiveRecord::Migration[6.1]
  def change
    rename_table('product', 'products')
  end
end
