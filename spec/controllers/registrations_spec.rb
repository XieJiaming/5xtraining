require 'rails_helper'
require 'spec_helper'

RSpec.describe RegistrationsController, type: :controller do 
  it '#new' do 
    get :new
    expect(response).to have_http_status(200)
    expect(response).to render_template(:new)
  end 

  describe '#create' do 
    before(:each) do 
      @user_params = { email: 'user@gmail.com', password: 'qwerty' }
    end
    it 'create new user' do 
      expect{ post :create, params: { user: @user_params } }.to change{User.all.size}.by(1)
    end 

    it 'redirect on success' do 
      post :create, params: { user: @user_params }
      expect(response).not_to have_http_status(200)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
    end

    it 'render :new on fail' do 
      allow_any_instance_of(User).to receive(:save).and_return(false)
      post :create, params: { user: @user_params }
      expect(response).not_to have_http_status(302)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end  
end
