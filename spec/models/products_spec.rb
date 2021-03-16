require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is accessible' do 
    product = Product.create(name: 'p1', price:100, stock: 0, scheduled_start: "2021-03-26 17:31:00.000000000 +0800", scheduled_end: "2021-04-08 17:31:00.000000000 +0800")
    expect(product).to eq(Product.last)
  end

  it 'it has name' do 
    columns = Product.column_names
    expect(columns).to include('name')
    expect(columns).to include('price')
    expect(columns).to include('stock')
    expect(columns).not_to include('product_id')
  end

  it 'validate name' do 
    expect(Product.create).not_to be_valid
    expect(Product.create(name: 'p2', price: 100, scheduled_start: "2021-03-26 17:31:00.000000000 +0800", scheduled_end: "2021-04-08 17:31:00.000000000 +0800")).to be_valid
  end

  it '.no_price' do 
    product_with_price = Product.create(name: 'p1', price: 200, scheduled_start: "2021-03-26 17:31:00.000000000 +0800", scheduled_end: "2021-04-08 17:31:00.000000000 +0800")
    product_without_price = Product.create(name: 'p2', price: nil, scheduled_start: "2021-03-26 17:31:00.000000000 +0800", scheduled_end: "2021-04-08 17:31:00.000000000 +0800")
    expect(Product.all).to include(product_with_price)
    expect(Product.no_price).not_to include(product_with_price)
  end

  it '#noStock' do 
    product = Product.create(name: 'p4', price:100, stock: 0)
    expect(product.noStock).to be(true)
    expect(product.noStock).not_to be(false)
  end
end
