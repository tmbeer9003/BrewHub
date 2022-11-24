class Public::ShopsController < ApplicationController
  before_action :authenticate_member!

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to request.referer, success: "お店情報を登録しました"
    else
      render "error"
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :location)
  end
end