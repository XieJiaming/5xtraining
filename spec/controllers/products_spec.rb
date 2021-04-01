require 'rails_helper'
require 'spec_helper'

RSpec.describe ProductsController, type: :controller do
  before(:each) do
    @user_params = {email: 'test@gmail.com', password: 'qwerty'}
    @user1 = User.create(email: @user_params[:email], password: @user_params[:password])
    login({id: @user1.id, email: @user_params[:email], password: @user_params[:password]})
    @product1 = Product.create(name: 'p1', price: 100, stock: 200, scheduled_start: "2021-03-09 15:50:00.000000000 +0800", scheduled_end: "2021-03-27 15:50:00.000000000 +0800", user_id: @user1.id)
    @product2 = Product.create(name: 'p2', price: 10, stock: 20, scheduled_start: "2021-03-09 15:50:00.000000000 +0800", scheduled_end: "2021-03-27 15:50:00.000000000 +0800", user_id: @user1.id)
    @product3 = Product.create(name: 'p3', price: 30, stock: 30, scheduled_start: "2021-03-09 15:50:00.000000000 +0800", scheduled_end: "2021-03-27 15:50:00.000000000 +0800", user_id: @user1.id)
  end

  it '#index' do
    get :index
    expect(response).to have_http_status(200)
    expect(response).to render_template(:index)
  end

  it '#new' do
    get :new
    expect(response).to have_http_status(200)
    expect(response).to render_template(:new)  
  end

  describe '#create' do
    before(:each) do 
      @user1 = User.create(email: 'test@gmail.com', password: 'qwerty')
      @product_params = {name: 'p4', price: 40, stock: 40, scheduled_start: "2021-03-09 15:50:00.000000000 +0800", scheduled_end: "2021-03-27 15:50:00.000000000 +0800"}
    end

    it 'create record' do 
      expect{ post :create, params: { product: @product_params } }.to change{Product.all.size}.by(1)
    end

    it 'redirect on success' do
      post :create, params: { product: @product_params }
      expect(response).not_to have_http_status(200)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
    end

    it 'render :new on fail' do 
      allow_any_instance_of(Product).to receive(:save).and_return(false)
      post :create, params: { product: @product_params }
      expect(response).not_to have_http_status(302)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  it '#edit' do
    get :edit, params: { id: @product1[:id] }
    expect(response).to have_http_status(200)
    expect(response).to render_template(:edit)
  end

  describe '#update' do 
    before(:each) do 
      @product_params = {name: 'p4', price: 40, stock: 400, scheduled_start: "2021-03-09 15:50:00.000000000 +0800", scheduled_end: "2021-03-27 15:50:00.000000000 +0800"}
    end

    it 'change record' do 
      post :update, params: { product: @product_params, id: @product2 }
      expect(Product.find(@product2[:id])[:name]).to eq('p4')
      expect(Product.find(@product2[:id])[:price]).to eq(40)
      expect(Product.find(@product2[:id])[:stock]).to eq(400)
    end

    it 'redirect on success' do 
      post :update, params: { product: @product_params, id: @product2 }
      expect(response).to have_http_status(302)
      expect(response).not_to have_http_status(200)
      expect(response).to redirect_to(root_path)
    end

    it 'render on fail' do 
      allow_any_instance_of(Product).to receive(:update).and_return(false)
      post :update, params: { product: @product_params, id: @product2 }
      expect(response).not_to have_http_status(302)
      expect(response).to render_template(:edit)
    end
  end

  describe '#destroy' do 

    it 'destroy record' do 
      expect{ delete :destroy, params: { id: @product3 } }.to change{Product.all.count}.by(-1)
    end

    it 'redirect to index after destroy' do 
      delete :destroy, params: { id: @product3[:id] }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
    end
  end
end