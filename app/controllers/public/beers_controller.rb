class Public::BeersController < ApplicationController

  def new
    @beer = Beer.new
    @breweries = Brewery.all
    @beer_styles = BeerStyle.all
  end

  def create
    @beer = Beer.new(beer_params)
    if @beer.save
      redirect_to request.referer
    else
      render "error"
    end
  end

  def index
    @breweries = Brewery.all
    @beer_styles = BeerStyle.all
    beer_search = params[:beer_search]
    refine_brewery = params[:refine_brewery]
    refine_beer_style = params[:refine_beer_style]
    if beer_search != nil
      @beers = Beer.where("name like ?", "%#{beer_search}%")
    elsif refine_brewery != nil
      @beers = Beer.where(brewery_id: refine_brewery)
    elsif refine_beer_style != nil
      @beers = Beer.where(beer_style_id: refine_beer_style)
    else
      @beers = Beer.all
    end
  end

  def show
    @beer = Beer.find(params[:id])
    @breweries = Brewery.all
    @beer_styles = BeerStyle.all
  end

  private

  def beer_params
    params.require(:beer).permit(:brewery_id, :beer_style_id, :name, :abv, :ibu, :description)
  end

end
