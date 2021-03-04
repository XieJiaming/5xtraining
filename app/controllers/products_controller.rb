class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        flash[:notice] = "成功建立"
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
        flash[:notice] = "修改成功"
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
        flash[:notice] = "成功刪除資料"
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
