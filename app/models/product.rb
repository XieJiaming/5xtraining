class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  
  scope :no_price, -> { where("price IS NULL") }

  def noStock
    self.stock == 0
  end
end