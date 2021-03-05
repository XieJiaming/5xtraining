require 'rails_helper'

RSpec.describe "products/index.html.erb", type: :view do 
  it 'can render' do 
    @product = Product.create(name: 'p1', price: 100, stock: 100)
    @products = Array.new(2, @product)
    render 
    expect(rendered).to include("Product List")
    expect(rendered).to include("p1")
    expect(rendered).to include("100")
    expect(rendered).to include("100")
  end
end