class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.log_in(session_params)

    respond_to do |format|
      if @user.present?
        session[:userkey] = @user.id
        format.html {
          flash[:alert] = "Successfully Log In"
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
    if current_user
      session[:userkey] = nil
      respond_to do |format|
        format.html {
          flash[:log_out] = 'Successfully Log Out'
          redirect_to root_path
        }
      end
    else
      redirect_to sign_in_path
    end
  end

  def show
    if current_user
      @user = current_user
    else
      redirect_to sign_in_path
    end
  end

  def update
    if current_user
      @user = User.find(current_user[:id])

      respond_to do |format|
        if @user.update(session_update_params)
          format.html {
            redirect_to root_path
          }
        else
          format.html {
            render :show
          }
        end
      end
    else
      redirect_to sign_in_path
    end
  end

  def delete_confirm
    if not current_user
      redirect_to sign_in_path
    end
  end

  def delete_account
    if current_user
      @user = User.find(current_user[:id])

      respond_to do |format|
        if @user.destroy
          flash[:notice] = 'Successfully Delete Account'
          format.html {
            redirect_to root_path
          }
        else 
          flash[:notice] = 'Something wrong'
          format.html {
            render :delete_confirm
          }
        end
      end
    else 
      redirect_to sign_in_path
    end
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end

  def session_update_params
    params.require(:user).permit(:password)
  end
end 