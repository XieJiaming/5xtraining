class ProductsController < ApplicationController
  before_action :find_product, only: [:edit, :update, :destroy]
  # after_action :verify_authorized, except: [:index, :new]

  def index
    if user_sign_in?
      if current_user.admin?
        @q = Product.search_keyword(params)
        @products = @q.result
        @products = @products.order_by_schedueldstart(params[:ordered]).order(created_at: :desc).page(params[:page])
      else
        @q = Product.search_keyword(params)
        @products = @q.result
        @products = @products.owned_by(current_user).order_by_schedueldstart(params[:ordered]).order(created_at: :desc).page(params[:page])
      end
      authorize @products
    else
      @q = Product.search_keyword(params)
      @products = nil
    end
  end

  def new
    if current_user
      @product = current_user.products.new
      authorize @product
    else
      respond_to do |format|
        format.html {
          flash[:notice] = 'You have to log in to access to the page'
          redirect_to root_path
        }
      end
    end
  end

  def create
    @product = current_user.products.new(product_params)
    respond_to do |format|
      if @product.scheduled_start > @product.scheduled_end
        format.html {
          flash[:schedule_notice] = t('.scheduled_error')
          render :new
        }
      else
        if @product.save
          format.html {
            flash[:notice] = t('.notice')
            redirect_to root_path
          }
        else
          format.html {
            flash[:notice] = 'something wrong'
            render :new
          }
        end  
      end
    end
  end

  def edit
    authorize @product
  end

  def update

    respond_to do |format|
      if product_params[:scheduled_start] > product_params[:scheduled_end]
        format.html {
          flash[:schedule_notice] = t('.scheduled_error')
          render :edit
        }
      else
        if @product.update(product_params)
          flash[:notice] = t('.notice')
          format.html {
            redirect_to root_path
          }
        else
          format.html {
            render :edit
          }
        end  
      end
    end
  end

  def destroy
    authorize @product
    respond_to do |format|
      if @product.destroy
        flash[:notice] = t('.notice')
        format.html {
          redirect_to root_path
        }
      end
    end
  end

  private
  def product_params
    product_params = params.require(:product).permit(:name, :price, :stock, :scheduled_start, :scheduled_end, :product_resolve)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
