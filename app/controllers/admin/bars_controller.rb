class Admin::BarsController < ApplicationController
  before_action :authenticate_admin!
  layout "application_no_sidebar"

  def new
    @bar = Bar.new
  end

  def create
    @bar = Bar.new(bar_params)
    render "error" unless @bar.save
    @bars = Bar.page(params[:page]).per(10)
    #非同期通信処理後の一覧表示用の記述
  end

  def index
    @bars = Bar.page(params[:page]).per(10)
    params[:id].nil? ? (@bar = Bar.new) : (@bar = Bar.find(params[:id]))
    # params[:id]に値がなければフォームを新規登録に、値があれば編集にする
  end

  def update
    @bar = Bar.find(params[:id])
    render "error" unless @bar.update(bar_params)
    #以下は非同期通信のための処理
    params[:id] = nil
    @bar_new = Bar.new
    #フォームを新規登録に戻す
    @bars = Bar.page(params[:page]).per(10)
    #一覧表示用の記述
  end

  def destroy
    @bar = Bar.find(params[:id])
    @bar.destroy
    #以下は非同期通信のための処理
    params[:id] = nil
    @bar_new = Bar.new
    #フォームを新規登録に戻す
    @bars = Bar.page(params[:page]).per(10)
    #一覧表示用の記述
  end

  def edit
    @bar = Bar.find(params[:id])
  end

  private

  def bar_params
    params.require(:bar).permit(:name, :location)
  end
end
