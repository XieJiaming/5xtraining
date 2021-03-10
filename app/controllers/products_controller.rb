class ProductsController < ApplicationController
  def index
    @products = Product.all.order(created_at: :desc)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        flash[:notice] = t('.notice')
        format.html {
          redirect_to root_path
        }
      else
        format.html {
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

  def destroy
    @product = Product.find(params[:id])

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
    product_params = params.require(:product).permit(:name, :price, :stock)
  end
end
