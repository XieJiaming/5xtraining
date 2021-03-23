require 'rails_helper'

RSpec.feature "Products", type: :feature do
  describe '#index order' do 
    it 'ordered :created_at by descent' do 
      visit root_path

      loaded_content = all('.row > .name').map(&:text)
      params = {}

      expect(Product.order_by_schedueldstart(params[:ordered]).order(created_at: :desc).page(params[:page]).pluck(:name)).to eq(loaded_content)  
    end

    it 'ordered :scheduled_start by descent' do 
      visit root_path(:params => { :ordered => "DESC"})

      loaded_content = all('.row > .name').map(&:text)

      params = {"ordered"=>"DESC"}

      expect(Product.search_keyword(params).result.order_by_schedueldstart(params[:ordered]).order(created_at: :desc).page(params[:page]).pluck(:name)).to eq(loaded_content)  
    end

    it 'ordered :scheduled_start by ascent' do 
      visit root_path(:params => { :ordered => "ASC"})

      loaded_content = all('.row > .name').map(&:text)

      params = {"ordered"=>"ASC"}

      expect(Product.search_keyword(params).result.order_by_schedueldstart(params[:ordered]).order(created_at: :desc).page(params[:page]).pluck(:name)).to eq(loaded_content)  
    end
  end

  describe '#index search' do 
    it 'search by name: has match' do 
      params = {"q"=>{"keyword_eq"=>"p1"}, "commit"=>"search"}
      visit root_path(params)

      loaded_content = all('.row > .name').map(&:text)
      counts = all('.row > .name').length

      expect(Product.search_keyword(params).result.order(created_at: :desc).page(params[:page]).pluck(:name)).to eq(loaded_content)
      expect(Product.search_keyword(params).result.order(created_at: :desc).page(params[:page]).pluck(:name).length).to eq(counts)
    end
    
    it 'search by name: does not match' do 
      params = {"q"=>{"keyword_eq"=>"qqqqq"}, "commit"=>"search"}
      visit root_path(params)

      loaded_content = all('.row > .name').map(&:text)
      counts = all('.row > .name').length

      expect(Product.search_keyword(params).result.order(created_at: :desc).page(params[:page]).pluck(:name)).to eq(loaded_content)
      expect(Product.search_keyword(params).result.order(created_at: :desc).page(params[:page]).pluck(:name).length).to eq(counts)

    end 

    it 'search by product_resolve: has match' do
      params = {"q"=>{"keyword_eq"=>"需叫貨"}, "commit"=>"search"}
      visit root_path(params)

      loaded_content = all('.row > .name').map(&:text)
      counts = all('.row > .name').length

      expect(Product.search_keyword(params).result.order(created_at: :desc).page(params[:page]).pluck(:name)).to eq(loaded_content)
      expect(Product.search_keyword(params).result.order(created_at: :desc).page(params[:page]).pluck(:name).length).to eq(counts)

    end

    it 'search by product_resolve: does not match' do 
      params = {"q"=>{"keyword_eq"=>"叫貨"}, "commit"=>"search"}
      visit root_path(params)

      loaded_content = all('.row > .name').map(&:text)
      counts = all('.row > .name').length

      expect(Product.search_keyword(params).result.order(created_at: :desc).page(params[:page]).pluck(:name)).to eq(loaded_content)
      expect(Product.search_keyword(params).result.order(created_at: :desc).page(params[:page]).pluck(:name).length).to eq(counts)

    end
  end
end
