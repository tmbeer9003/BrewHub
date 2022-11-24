class Admin::BeerStylesController < ApplicationController
  before_action :authenticate_admin!
  layout "application_no_sidebar"

  def create
    @beer_style = BeerStyle.new(beer_style_params)
    if @beer_style.save
      redirect_to admin_beer_styles_path, success: "ビアスタイル情報を登録しました"
    else
      render "error"
    end
  end

  def index
    @beer_styles = BeerStyle.page(params[:page]).per(10)
    if params[:id] != nil
      @beer_style = BeerStyle.find(params[:id])
    else
      @beer_style = BeerStyle.new
    end
  end

  def update
    @beer_style = BeerStyle.find(params[:id])
    if @beer_style.update(beer_style_params)
      params[:id] = nil
      redirect_to admin_beer_styles_path, success: "ビアスタイル情報を更新しました"
    else
      render "error"
    end
  end

  def destroy
    @beer_style = BeerStyle.find(params[:id])
    @beer_styles = BeerStyle.page(params[:page]).per(10)
    @beer_style.destroy
  end

  def edit
    @beer_style = BeerStyle.find(params[:id])
  end

  private

  def beer_style_params
    params.require(:beer_style).permit(:name, :category)
  end
end
