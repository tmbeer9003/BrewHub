class Public::ShopsController < ApplicationController
  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to request.referrer
    else
      render "error"
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :location)
  end
end