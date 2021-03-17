require 'rails_helper'

RSpec.feature "Products", type: :feature do
  describe '#index order' do 
    it 'ordered by descent' do 
      visit root_path

      loaded_content = all('.row > .name').map(&:text)

      expect(Product.order(created_at: :desc).pluck(:name)).to eq(loaded_content)  
    end
  end
end
