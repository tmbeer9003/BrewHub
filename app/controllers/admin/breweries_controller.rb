class Admin::BreweriesController < ApplicationController

  def create
    @brewery = Brewery.new(brewery_params)
    if @brewery.save
      redirect_to request.referer
    else
      render "error"
    end
  end

  def index
    @breweries = Brewery.page(params[:page]).per(10)
    if params[:id] != nil
      @brewery = Brewery.find(params[:id])
    else
      @brewery = Brewery.new
    end
  end

  def update
    @brewery = Brewery.find(params[:id])
    if @brewery.update(brewery_params)
      params[:id] = nil
      redirect_to admin_breweries_path
    else
      render "error"
    end
  end

  def destroy
    @brewery = Brewery.find(params[:id])
    @breweries = Brewery.page(params[:page]).per(10)
    @brewery.destroy
  end

  private

  def brewery_params
    params.require(:brewery).permit(:name, :description, :location)
  end
end
