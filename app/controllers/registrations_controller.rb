class RegistrationsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)
    respond_to do |format|
      if @user.save
        session[:userkey] = @user.id
        format.html {
          redirect_to root_path
        }
      else
        format.html {
          flash[:alert] = 'Something wrong'
          render :new
        }
      end
    end
  end

  private

  def registration_params
    params.require(:user).permit(:email, :password)
  end
end
