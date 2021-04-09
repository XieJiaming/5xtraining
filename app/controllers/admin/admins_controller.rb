class Admin::AdminsController < ApplicationController

  def user
    @users = User.includes(:products)
    authorize @users, :admin_user?
  end 

  def user_new
    @user = User.new
  end

  def user_create
    @user = User.new(registration_params)

    respond_to do |format|
      if @user.save
        format.html {
          flash[:alert] = 'Successfully Add New User'
          redirect_to user_admin_admins_path
        }
      else
        format.html {
          flash[:alert] = 'Something wrong'
          render :user_new
        }
      end
    end
  end

  def user_destroy
    @user = User.find(params[:id])

    if @user.destroy
      flash[:notice] = 'Successfully Delete Account'
    else 
      flash[:notice] = @user.errors.full_messages
    end
    redirect_to user_admin_admins_path
  end

  def user_edit
    @user = User.find(params[:id])
  end

  def user_update
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
          redirect_to user_admin_admins_path
        }
      else
        format.html {
          render :user_edit
        }
      end
    end
  end

  def product 
    @products = Product.all
    authorize @products, :admin_user?
  end

  def product_new 
    @product = Product.new
    authorize @products, :admin_user?    
  end

  def product_create
    @product = Product.new(product_params)
    @product.user_id = params[:user_id]
    respond_to do |format|
      if @product.save
        format.html {
          flash[:alert] = 'Successfully Add New Product'
          redirect_to user_product_admin_admin_path(params[:user_id])
        }
      else
        format.html {
          flash[:alert] = 'Something wrong'
          render :product_new
        }
      end
    end
  end

  def product_edit
    @product = Product.find(params[:id])
  end

  def product_update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update(product_params)
        format.html {
          flash[:alert] = 'Successfully Edit Product'
          redirect_to product_admin_admins_path
        }
      else
        format.html {
          flash[:alert] = 'Something wrong'
          render :product_edit
        }
      end
    end
  end

  def product_destroy
    @product = Product.find(params[:id])

    if @product.destroy
      flash[:notice] = 'Successfully Delete Product'
    else 
      flash[:notice] = 'Something wrong'
    end
    redirect_to after_delete_product
    # redirect_to product_admin_admins_path
  end

  def user_products_show
    @user = User.find(params[:id])
    @products = Product.where(user_id: params[:id])
  end

  private

  def session_update_params
    params.require(:user).permit(:password, :name, :email, :admin)
  end

  def registration_params
    params.require(:user).permit(:email, :password, :name, :admin)
  end

  def product_params
    product_params = params.require(:product).permit(:name, :price, :stock, :scheduled_start, :scheduled_end, :product_resolve)
  end
end