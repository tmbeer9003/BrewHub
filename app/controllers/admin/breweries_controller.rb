class Admin::BreweriesController < ApplicationController
  before_action :authenticate_admin!
  layout "application_no_sidebar"

  def create
    @brewery = Brewery.new(brewery_params)
    if @brewery.save
      redirect_to admin_breweries_path, success: "ブルワリー情報を登録しました"
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
      redirect_to admin_breweries_path, success: "ブルワリー情報を更新しました"
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
