class RemoveProductRef < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :users_id
  end
end
