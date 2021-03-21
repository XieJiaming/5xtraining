class ProductsController < ApplicationController
  def index
    @q = Product.search_keyword(params)
    @products = @q.result.order_by_schedueldstart(params[:ordered]).order(created_at: :desc)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.scheduled_start > @product.scheduled_end
        format.html {
          flash[:schedule_notice] = t('.scheduled_error')
          render :new
        }
      else
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
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

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
    product_params = params.require(:product).permit(:name, :price, :stock, :scheduled_start, :scheduled_end, :product_resolve)
  end
end
