class Public::ShopsController < ApplicationController
  def create
    @shop = Shop.new(shop_params)
    unless @shop.save
      render "error"
    end
  end

  private

  def bar_params
    params.require(:shop).permit(:name, :location)
  end
end
