require 'rails_helper'

RSpec.describe 'products/edit.html.erb', type: :view do 
  before(:each) do 
    @user1 = User.create(email: 'test@gmail.com', password: 'qwerty')
    @product = Product.create(name: 'p1', price: 100, stock:100, scheduled_start: "2021-03-09 15:50:00.000000000 +0800", scheduled_end: "2021-03-27 15:50:00.000000000 +0800", user_id: @user1.id)
  end 

  it 'render partial' do 
    render
    expect(response).to render_template(partial: "_form")
  end

  it 'has link' do 
    render
    expect(rendered).to include('Back to product list page')
    expect(rendered).to include('更新產品')
  end
end