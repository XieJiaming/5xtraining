class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  
  scope :no_price, -> { where("price is null") }

  def noStock
    self.stock == 0
  end
end