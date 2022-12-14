class Public::BeersController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show]

  def new
    @beer = Beer.new
    @breweries = Brewery.all
    @beer_styles = BeerStyle.all
  end

  def create
    @beer = Beer.new(beer_params)
    @beer.save ? (redirect_to beer_path(@beer), success: "ビール情報を登録しました") : (render "error")
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
    if @beer_search.present?
      beers = Beer.where("name like ?", "%#{@beer_search}%")
    elsif @refine_brewery.present?
      beers = Beer.where(brewery_id: @refine_brewery)
    elsif @refine_beer_style.present?
      beers = Beer.where(beer_style_id: @refine_beer_style)
    else
      beers = Beer.all
    end
    @beers = beers.order(evaluation: :desc).page(params[:page]).per(10)
  end

  def show
    @beer = Beer.find(params[:id])
    @breweries = Brewery.all
    @beer_styles = BeerStyle.all
    @posts = @beer.posts.order(id: :desc).page(params[:page]).per(7)
    @bars = @beer.drunk_bars.distinct.order(place_name: :asc)
    # @beerが飲まれた（紐づけられた）お店のデータを取得し重複を排除、所在地の昇順で並べ替える
    @shops = @beer.purchased_shops.distinct.order(place_name: :asc)
    # @beerが買われた（紐づけられた）お店のデータを取得し重複を排除、所在地の昇順で並べ替える
    gon.bars = @beer.drunk_bars.distinct
    gon.shops = @beer.purchased_shops.distinct
  end

  private
    def beer_params
      params.require(:beer).permit(:brewery_id, :beer_style_id, :name, :abv, :ibu, :description)
    end
end
