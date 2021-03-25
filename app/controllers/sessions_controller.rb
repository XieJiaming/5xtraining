class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(session_params)
    respond_to do |format|
      if @user.present?
        session[:userkey] = @user.id
        format.html {
          redirect_to root_path
        }
      else
        format.html {
          @user = User.new
          flash[:alert] = 'Something wrong'
          render :new
        }
      end
    end
  end

  def destroy
    session[:userkey] = nil
    respond_to do |format|
      format.html {
        flash[:log_out] = 'Log Out'
        redirect_to root_path
      }
    end
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end 