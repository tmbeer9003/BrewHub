class Admin::BeerStylesController < ApplicationController
  before_action :authenticate_admin!
  layout "application_no_sidebar"

  def new
    @beer_style = BeerStyle.new
  end

  def create
    @beer_style = BeerStyle.new(beer_style_params)
    render "error" unless @beer_style.save
    @beer_styles = BeerStyle.page(params[:page]).per(10)
    #非同期通信処理後の一覧表示用の記述
  end

  def index
    @beer_styles = BeerStyle.page(params[:page]).per(10)
    params[:id].nil? ? (@beer_style = BeerStyle.new) : (@beer_style = BeerStyle.find(params[:id]))
    # params[:id]に値がなければフォームを新規登録に、値があれば編集にする
  end

  def update
    @beer_style = BeerStyle.find(params[:id])
    render "error" unless @beer_style.update(beer_style_params)
    #以下は非同期通信のための処理
    params[:id] = nil
    @beer_style_new = BeerStyle.new
    #フォームを新規登録に戻す
    @beer_styles = BeerStyle.page(params[:page]).per(10)
    #一覧表示用の記述
  end

  def destroy
    @beer_style = BeerStyle.find(params[:id])
    @beer_style.destroy
    #以下は非同期通信のための処理
    params[:id] = nil
    @beer_style_new = BeerStyle.new
    #フォームを新規登録に戻す
    @beer_styles = BeerStyle.page(params[:page]).per(10)
    #一覧表示用の記述
  end

  def edit
    @beer_style = BeerStyle.find(params[:id])
  end

  private

  def beer_style_params
    params.require(:beer_style).permit(:name, :category)
  end
end
