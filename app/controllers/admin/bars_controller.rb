class Admin::BarsController < ApplicationController
  before_action :authenticate_admin!
  layout "application_no_sidebar"

  def create
    @bar = Bar.new(bar_params)
    render "error" unless @bar.save
    @bars = Bar.where(category: 0).page(params[:page]).per(10)
    @shops = Bar.where(category: 1).page(params[:page]).per(10)
    # 非同期通信処理後の一覧表示用の記述
  end

  def index
    @bars = Bar.where(category: 0).page(params[:page]).per(10)
    @shops = Bar.where(category: 1).page(params[:page]).per(10)
    params[:id].nil? ? (@bar = Bar.new) : (@bar = Bar.find(params[:id]))
    # params[:id]に値がなければフォームを新規登録に、値があれば編集にする
  end

  def destroy
    @bar = Bar.find(params[:id])
    @bar.destroy
    # 以下は非同期通信のための処理
    params[:id] = nil
    @bar_new = Bar.new
    # フォームを新規登録に戻す
    @bars = Bar.where(category: 0).page(params[:page]).per(10)
    @shops = Bar.where(category: 1).page(params[:page]).per(10)
    # 一覧表示用の記述
  end

  private
    def bar_params
      params.require(:bar).permit(:category, :place_name, :latitude, :longitude)
    end
end
