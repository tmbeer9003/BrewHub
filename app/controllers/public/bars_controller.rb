class Public::BarsController < ApplicationController
  before_action :authenticate_member!

  def create
    @bar = Bar.new(bar_params)
    @bar.save ? (redirect_to request.referer, success: "お店情報を登録しました") : (render "error")
  end

  private

  def bar_params
    params.require(:bar).permit(:name, :location)
  end
end
