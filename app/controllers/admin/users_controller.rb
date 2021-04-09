class Admin::UsersController < ApplicationController
  def index
    @users = User.includes(:products)
    authorize @users, :admin_user?
  end 

  def new
    @user = User.new
  end  

  def create
    @user = User.new(registration_params)

    respond_to do |format|
      if @user.save
        format.html {
          flash[:alert] = 'Successfully Add New User'
          redirect_to admin_users_path
        }
      else
        format.html {
          flash[:alert] = 'Something wrong'
          render :new
        }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      flash[:notice] = 'Successfully Delete Account'
    else 
      flash[:notice] = @user.errors.full_messages
    end
    redirect_to admin_users_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(
          {
            :admin => params[:user][:admin],
            :name => params[:user][:name],
            :email => params[:user][:email],
            :password => Digest::SHA1.hexdigest("a#{params[:user][:password]}z")
          }
        )
        format.html {
          redirect_to admin_users_path
        }
      else
        format.html {
          render :edit
        }
      end
    end
  end

  def products_show
    @user = User.find(params[:id])
    @products = Product.where(user_id: params[:id])
  end

  
  private

  def registration_params
    params.require(:user).permit(:email, :password, :name, :admin)
  end
end
