class Product < ApplicationRecord
  validates :name, presence: true
  scope :no_price, -> { where("price is null") }

end