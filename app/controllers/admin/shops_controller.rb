class Admin::ShopsController < ApplicationController
  before_action :authenticate_admin!
  layout "application_no_sidebar"

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    render "error" unless @shop.save
    @shops = Shop.page(params[:page]).per(10)
    #非同期通信処理後の一覧表示用の記述
  end

  def index
    @shops = Shop.page(params[:page]).per(10)
    params[:id].nil? ? (@shop = Shop.new) : (@shop = Shop.find(params[:id]))
    # params[:id]に値がなければフォームを新規登録に、値があれば編集にする
  end

  def update
    @shop = Shop.find(params[:id])
    render "error" unless @shop.update(shop_params)
    #以下は非同期通信のための処理
    params[:id] = nil
    @shop_new = Shop.new
    #フォームを新規登録に戻す
    @shops = Shop.page(params[:page]).per(10)
    #一覧表示用の記述
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
    #以下は非同期通信のための処理
    params[:id] = nil
    @shop_new = Shop.new
    #フォームを新規登録に戻す
    @shops = Shop.page(params[:page]).per(10)
    #一覧表示用の記述
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :location)
  end
end