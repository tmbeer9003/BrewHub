class Public::BarsController < ApplicationController
  def create
    @bar = Bar.new(bar_params)
    unless @bar.save
      render "error"
    end
  end

  private

  def bar_params
    params.require(:bar).permit(:name, :location)
  end
end
