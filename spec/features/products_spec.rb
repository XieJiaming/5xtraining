require 'rails_helper'

RSpec.feature "Products", type: :feature do
  describe 'list all products' do 
    context 'when list page found' do 
      it 'show all products including its details' do 
        products = 5.times { |time| Product.create(name: `p#{time}`, price: time*100, stock: time*20) }
  
        visit root_path
  
        names = all('.row > div:first-child').map(&:text)
        result = Product.all.map { |product| product.name }
        expect(names).to eq names
      end
    end

    context 'when list page not found' do 

    end
  end

  describe 'create a new product' do 
  end

  describe 'edit product' do 

  end 

  describe 'delete product' do 

  end
end
