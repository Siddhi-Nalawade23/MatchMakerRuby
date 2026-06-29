class ShopsController < ApplicationController
  protect_from_forgery with: :null_session

  # Get all shops
  def index
    @shops = Shop.all
  end

  # Get shop by ID
  def show
    @shop = Shop.find(params[:id])
  end

  # Create Shop
  def create
    @shop = Shop.create(shop_params)
    render json: @shop
  end

  def destroy
  @shop = Shop.find(params[:id])
  @shop.destroy

  render json: {
    message: "Shop deleted successfully"
  }
  end

  private

  def shop_params
    params.permit(:name, :location)
  end
end
