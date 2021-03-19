require 'rails_helper'

RSpec.describe "products/index.html.erb", type: :view do 
  it 'can render' do 
    @product = Product.create(name: 'p1', price: 100, stock: 100, scheduled_start: "2021-03-09 15:50:00.000000000 +0800", scheduled_end: "2021-03-27 15:50:00.000000000 +0800")
    @products = Array.new(2, @product)
    render 
    expect(rendered).to include("Product List")
    expect(rendered).to include("p1")
    expect(rendered).to include("100")
    expect(rendered).to include("100")
    expect(rendered).to include("2021/03/09")
    expect(rendered).to include("2021/03/27")
    expect(rendered).to include("不需叫貨")
  end
end