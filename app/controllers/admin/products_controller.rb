class Admin::ProductsController < ApplicationController

  def index 
    @products = Product.all
    authorize @products, :admin_user?
  end

  def new 
    @product = Product.new
    authorize @product, :admin_user?    
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = params[:user_id]
    byebug
    respond_to do |format|
      if @product.save
        format.html {
          flash[:alert] = 'Successfully Add New Product'
          redirect_to user_product_admin_user_path(params[:user_id])
        }
      else
        format.html {
          flash[:alert] = 'Something wrong'
          render :new
        }
      end
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update(product_params)
        format.html {
          flash[:alert] = 'Successfully Edit Product'
          redirect_to user_product_admin_user_path(params[:user_id])
        }
      else
        format.html {
          flash[:alert] = 'Something wrong'
          render :edit
        }
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])

    if @product.destroy
      flash[:notice] = 'Successfully Delete Product'
    else 
      flash[:notice] = 'Something wrong'
    end
    redirect_to user_product_admin_user_path(@product.user_id)
  end

  private

  def product_params
    product_params = params.require(:product).permit(:name, :price, :stock, :scheduled_start, :scheduled_end, :product_resolve, :all_tags)
  end
end
