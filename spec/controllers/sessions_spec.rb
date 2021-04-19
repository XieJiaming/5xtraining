require 'rails_helper'
require 'spec_helper'
RSpec.describe SessionsController, type: :controller do 
  def log_in
    User.create(email: 'user@gmail.com', password: 'qwerty')
    @session_params = { email: 'user@gmail.com', password: 'qwerty' }
    post :create, params: { user: @session_params }
  end
  
  it '#new' do
    get :new 
    expect(response).to have_http_status(200)
    expect(response).to render_template(:new)
  end

  describe '#create' do 
    before(:each) do 
      User.create(email: 'user@gmail.com', password: 'qwerty')
      @session_params = { email: 'user@gmail.com', password: 'qwerty' }
    end

    it 'create session' do 
      post :create, params: { user: @session_params } 
      expect(session).to be_present
    end

    it 'redirect on success' do 
      post :create, params: { user: @session_params }
      expect(response).not_to have_http_status(200)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
    end 

    it 'render :new on fail' do 
      allow_any_instance_of(User).to receive(:present?).and_return(false)
      post :create, params: { user: @session_params }
      expect(response).not_to have_http_status(302)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end   
  end

  describe '#show' do 
    it 'log in: has permission to show' do 
      log_in
      get :show
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)  
    end

    it 'not log in: not have permission to show, redirect to :new page' do 
      get :show
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(sign_in_path)
    end
  end

  describe '#update' do 

    it 'log in: can show but not validate password' do 
      log_in
      allow_any_instance_of(User).to receive(:update).and_return(false)
      post :update, params: { user: {email: 'aa@gmail.com'}}
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end 

    it 'log in: can show and validate password' do 
      log_in
      post :update, params: { user: {password: '123456'}}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
    end

    it 'not log in: redirect to  :new page' do 
      post :update, params: { user: {password: '123456'}}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(sign_in_path)
    end
  end 

  describe '#destroy' do 
    it 'log in: can log out' do 
      log_in
      delete :destroy
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
    end

    it 'not log in: redirect to sign in page' do 
      delete :destroy
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(sign_in_path)
    end
  end

  describe '#delete_confirm' do
    it 'not log in' do 
      get :delete_confirm
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(sign_in_path)
    end

    it 'log in' do 
      log_in
      get :delete_confirm
      expect(response).to have_http_status(200)
      expect(response).to render_template(:delete_confirm)
    end
  end

  describe '#delete account' do 
    it 'log in: successfully delete the account' do 
      log_in
      delete :delete_account
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
    end

    it 'log in: fail to  delete the account' do 
      log_in
      allow_any_instance_of(User).to receive(:destroy).and_return(false)
      delete :delete_account
      expect(response).to have_http_status(200)
      expect(response).to render_template(:delete_confirm)
    end

    it 'not log in: has no permission to delete account' do 
      delete :delete_account
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(sign_in_path)
    end
  end
end
