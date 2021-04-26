require 'rails_helper'
require 'spec_helper'

RSpec.describe Admin::ProductsController, type: :controller do 
  def log_in
    User.create(email: 'test@gmail.com', password: 'qwerty', admin: true)
    @session_params = { email: 'test@gmail.com', password: 'qwerty' }
    @user = User.log_in(@session_params)
    session[:userkey] = @user.id
  end

  before(:each) do 
    log_in
  end

  describe '#index' do 
    it 'has permission to access the index page' do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  it '#new' do 
    get :new
    expect(response).to have_http_status(200)
    expect(response).to render_template(:new)
  end

  describe '#create' do
    before(:each) do 
      @product_params = { name: 'p1', price: 100, stock: 12, scheduled_start: "2021-03-09 15:50:00.000000000 +0800", scheduled_end: "2021-03-27 15:50:00.000000000 +0800", product_resolve: '不需叫貨', all_tags: ''}
    end 

    it 'successfully create product' do
      post :create, params: { product: @product_params, user_id: @user.id }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(user_product_admin_user_path(@user.id))  
    end

    it 'render :new on fail to create product' do 
      allow_any_instance_of(Product).to receive(:save).and_return(false)
      post :create, params: { product: @product_params, user_id: @user.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  it '#edit' do
    product = @user.products.create(name: 'p1', price: 100, stock: 12, scheduled_start: "2021-03-09 15:50:00.000000000 +0800", scheduled_end: "2021-03-27 15:50:00.000000000 +0800", product_resolve: '不需叫貨', all_tags: '')
    get :edit, params: {id: product.id}

    expect(response).to have_http_status(200)
    expect(response).to render_template(:edit)
  end

  describe '#update' do 
    before(:each) do
      @product = @user.products.create(name: 'p1', price: 100, stock: 12, scheduled_start: "2021-03-09 15:50:00.000000000 +0800", scheduled_end: "2021-03-27 15:50:00.000000000 +0800", product_resolve: '不需叫貨', all_tags: '')
      @product_params = { name: 'p2', price: 200, stock: 22}

    end

    it 'successfully on update' do 
      put :update, params: { id: @product.id, product: @product_params , user_id: @user.id}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(user_product_admin_user_path(@user.id))
    end

    it 'render :edit on fail to update' do 
      allow_any_instance_of(Product).to receive(:update).and_return(false)
      put :update, params: { id: @product.id, product: @product_params , user_id: @user.id}
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end

  it '#destroy' do
    @product = @user.products.create(name: 'p1', price: 100, stock: 12, scheduled_start: "2021-03-09 15:50:00.000000000 +0800", scheduled_end: "2021-03-27 15:50:00.000000000 +0800", product_resolve: '不需叫貨', all_tags: '')
    
    delete :destroy, params: { id: @product.id }

    expect(response).to have_http_status(302)
    expect(response).to redirect_to(user_product_admin_user_path(@product.user_id))
  end 

end
