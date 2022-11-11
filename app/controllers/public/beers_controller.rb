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
    @beers = Beer.all
  end

  def show
    @beer = Beer.find(params[:id])
  end
  
  private
  
  def beer_params
    params.require(:beer).permit(:brewery_id, :beer_style_id, :name, :abv, :ibu, :description)
  end

end
