class Admin::BreweriesController < ApplicationController
  before_action :authenticate_admin!
  layout "application_no_sidebar"

  def new
    @brewery = Brewery.new
  end

  def create
    @brewery = Brewery.new(brewery_params)
    render "error" unless @brewery.save
    @breweries = Brewery.page(params[:page]).per(10)
    #非同期通信処理後の一覧表示用の記述
  end

  def index
    @breweries = Brewery.page(params[:page]).per(10)
    params[:id].nil? ? (@brewery = Brewery.new) : (@brewery = Brewery.find(params[:id]))
    # params[:id]に値がなければフォームを新規登録に、値があれば編集にする
  end

  def update
    @brewery = Brewery.find(params[:id])
    render "error" unless @brewery.update(brewery_params)
    #以下は非同期通信のための記述
    params[:id] = nil
    @brewery_new = Brewery.new
    #フォームを新規登録に戻す
    @breweries = Brewery.page(params[:page]).per(10)
    #一覧表示用の記述
  end

  def destroy
    @brewery = Brewery.find(params[:id])
    @brewery.destroy
    #以下は非同期通信のための記述
    params[:id] = nil
    @brewery_new = Brewery.new
    #フォームを新規登録に戻す
    @breweries = Brewery.page(params[:page]).per(10)
    #一覧表示用の記述
  end

  def edit
    @brewery = Brewery.find(params[:id])
  end

  private

  def brewery_params
    params.require(:brewery).permit(:name, :description, :location)
  end
end
