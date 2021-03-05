require 'rails_helper'

RSpec.describe 'products/edit.html.erb', type: :view do 
  before(:each) do 
    @product = Product.create(name: 'p1', price: 100, stock:100)
  end 

  it 'render partial' do 
    render
    expect(response).to render_template(partial: "_form")
  end

  it 'has link' do 
    render
    expect(rendered).to include('Back to product list page')
    expect(rendered).to include('Edit Product')
  end
end