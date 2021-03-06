require 'rails_helper'

RSpec.describe "products/index.html.erb", type: :view do 
  before(:each) do 
    @user1 = User.create(email: 'test@gmail.com', password: 'qwerty')
    @product = Product.create(name: 'p1', price: 100, stock: 100, scheduled_start: "2021-03-09 15:50:00.000000000 +0800", scheduled_end: "2021-03-27 15:50:00.000000000 +0800", user_id: @user1.id)    
    params = {"q"=>{"keyword_eq"=>""}, "commit"=>"search"}
    @q = Product.search_keyword(params)
    @products = @q.result.order_by_schedueldstart(params[:ordered]).order(created_at: :desc).page(params[:page])

    # @q = Product.ransack
    # @product = Product.create(name: 'p1', price: 100, stock: 100, scheduled_start: "2021-03-09 15:50:00.000000000 +0800", scheduled_end: "2021-03-27 15:50:00.000000000 +0800")
    # @products = Array.new(2, @product)
  end 
  it 'can render' do 
    render 
    expect(rendered).to include("Product List")
    expect(rendered).to include("p1")
    expect(rendered).to include("100")
    expect(rendered).to include("100")
    expect(rendered).to include("2021/03/09")
    expect(rendered).to include("2021/03/27")
    expect(rendered).to include("不需叫貨")
  end
  it 'contain search button' do 
    render
    expect(rendered).to include('search')
  end
end