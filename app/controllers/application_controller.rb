class ApplicationController < ActionController::Base
  helper_method :my_posts, :top_beer_all, :top_beer_1, :top_beer_2, :top_beer_3, :top_beer_4

  add_flash_types :success, :warning

  private

  def my_posts
    current_member.posts.order(id: :desc).limit(9) if member_signed_in?
  end

  def top_beer_all
    Beer.order(evaluation: :desc).first
  end

  def top_beer_1
    Beer.where(beer_style_id: current_member.my_beer_style1_id).order(evaluation: :desc).first
  end

  def top_beer_2
    Beer.where(beer_style_id: current_member.my_beer_style2_id).order(evaluation: :desc).first
  end

  def top_beer_3
    Beer.where(beer_style_id: current_member.my_beer_style3_id).order(evaluation: :desc).first
  end

  def top_beer_4
    Beer.where(beer_style_id: current_member.my_beer_style4_id).order(evaluation: :desc).first
  end

end
