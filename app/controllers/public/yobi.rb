class Public::HomesController < ApplicationController

  def top
    render layout: "application_no_sidebar"
  end

  def timeline
    followings = current_member.followings
    timeline_posts = Post.where(member_id: followings).or(Post.where(member_id: current_member.id))
    # フォローしているユーザーと自分の投稿に絞り込み
    post_search = params[:post_search]
    # 投稿検索で受け取った値を代入
    if post_search != nil
      @posts = timeline_posts.where("content like ?", "%#{post_search}%").order(id: :desc)
    else
      @posts = timeline_posts.order(id: :desc)
    end
  end

  def cheers_list
    cheers_list = current_member.cheers
    # ログインユーザーのCheersを絞り込み
    post_search = params[:post_search]
    # 投稿検索で受け取った値を代入
    if post_search != nil
      @cheers = cheers_list.where("content like ?", "%#{post_search}%").order(id: :desc)
      #要修正
    else
      @cheers = cheers_list.order(id: :desc)
    end
  end

end
