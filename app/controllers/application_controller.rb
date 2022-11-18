class ApplicationController < ActionController::Base
  helper_method :my_posts, :top_beer_all, :top_beer_1, :top_beer_2, :top_beer_3, :top_beer_4
  
  private 
  
  def my_posts
    if member_signed_in?
      current_member.posts.order(id: :desc).limit(9)
    end
  end
  
  def top_beer_all
    Beer.order(evaluation: :desc).first
  end
  
  def top_beer_1
    Beer.where(beer_style_id: 26).order(evaluation: :desc).first
  end
  
  def top_beer_2
    Beer.where(beer_style_id: 2).order(evaluation: :desc).first
  end
  
  def top_beer_3
    Beer.where(beer_style_id: 3).order(evaluation: :desc).first
  end
  
  def top_beer_4
    Beer.where(beer_style_id: 21).order(evaluation: :desc).first
  end

end
