class AddProductReference < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :users
  end
end
