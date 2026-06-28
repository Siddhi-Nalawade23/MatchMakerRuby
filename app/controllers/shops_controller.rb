class ShopsController < ApplicationController
    # Get all shops
    def index
        @shops=Shop.all
    end
    # Get shop by ID 
    def show
        @shop=Shop.find(params[:id])
    end
    # Create Shop
    protect_from_forgery with: :null_session
    def create
    @shop = Shop.create(shop_params)
    render json: @shop
  end
  private
  def shop_params
    params.permit(:name, :location)
  end
 protect_from_forgery with: :null_session
  def destroy 
    @shop=Shop.distory(params:id)
    render json:{
        messgae:"shop deleted sucessfully"
    }
  end 
  def exmaple_method 
    puts "hello world"
  end 
  def emaple2
    puts "hello here"
  end 
end
