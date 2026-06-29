class ProductsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    render "index"
  end

  # create product
  def create
    @product = Product.create(prod_params)
    render json: @product
  end

  private

  def prod_params
    params.permit(:id, :name, :price, :shop_id, :created_at, :updated_at)
  end
end