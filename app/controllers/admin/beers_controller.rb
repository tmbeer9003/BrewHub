class Admin::BeersController < ApplicationController
  before_action :authenticate_admin!
  layout "application_no_sidebar"

  def new
    @beer = Beer.new
    @breweries = Brewery.all
    @beer_styles = BeerStyle.all
  end

  def create
    @beer = Beer.new(beer_params)
    @beer.save ? (redirect_to admin_beer_path(@beer), success: "ビール情報を登録しました") : (render "error")
  end

  def index
    @breweries = Brewery.all
    @beer_styles = BeerStyle.all
    @beer_search = params[:beer_search]
    # ビール（キーワード）検索で受け取った値を代入
    @refine_brewery = params[:refine_brewery]
    # ブルワリー検索で受け取った値を代入
    @refine_beer_style = params[:refine_beer_style]
    # ビアスタイル検索で受け取った値を代入
    if @beer_search != nil
      @beers = Beer.where("name like ?", "%#{@beer_search}%").order(evaluation: :desc).page(params[:page]).per(10)
    elsif @refine_brewery != nil
      @beers = Beer.where(brewery_id: @refine_brewery).order(evaluation: :desc).page(params[:page]).per(10)
    elsif @refine_beer_style != nil
      @beers = Beer.where(beer_style_id: @refine_beer_style).order(evaluation: :desc).page(params[:page]).per(10)
    else
      @beers = Beer.order(evaluation: :desc).page(params[:page]).per(10)
    end
  end

  def show
    @beer = Beer.find(params[:id])
    @breweries = Brewery.all
    @beer_styles = BeerStyle.all
    @posts = @beer.posts.order(id: :desc).page(params[:page]).per(7)
    @bars = @beer.drunk_bars.distinct.order(location: :asc)
    # @beerが飲まれた（紐づけられた）お店のデータを取得し重複を排除、所在地の昇順で並べ替える
    @shops = @beer.purchased_shops.distinct.order(location: :asc)
    # @beerが買われた（紐づけられた）お店のデータを取得し重複を排除、所在地の昇順で並べ替える
  end

  def edit
    @beer = Beer.find(params[:id])
    @breweries = Brewery.all
    @beer_styles = BeerStyle.all
  end

  def update
    @beer = Beer.find(params[:id])
    @beer.update(beer_params) ? (redirect_to admin_beer_path(@beer), success: "ビール情報を更新しました") : (render "error")
  end

  def destroy
    @beer = Beer.find(params[:id])
    @beer.destroy
    redirect_to admin_beers_path, alert: "ビール情報を削除しました"
  end

  private
    def beer_params
      params.require(:beer).permit(:brewery_id, :beer_style_id, :name, :abv, :ibu, :description)
    end
end
