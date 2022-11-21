class Public::BarsController < ApplicationController
  def create
    @bar = Bar.new(bar_params)
    if @bar.save
      redirect_to request.referrer
    else
      render "error"
    end
  end

  private

  def bar_params
    params.require(:bar).permit(:name, :location)
  end
end
