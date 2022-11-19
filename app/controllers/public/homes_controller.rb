class Public::HomesController < ApplicationController

  def top
    render layout: "application_no_sidebar"
  end

  def timeline
    followings = current_member.followings
    timeline_posts = Post.where(member_id: followings).or(Post.where(member_id: current_member.id))
    # 投稿一覧をフォローしているユーザーと自分の投稿に絞り込み
    post_search = params[:post_search]
    # 投稿検索で受け取った値を代入
    if post_search != nil
    #検索から遷移したら
      @posts = timeline_posts.where("content like ?", "%#{post_search}%").order(id: :desc)
    else
      @posts = timeline_posts.order(id: :desc)
    end
  end

  def cheers_list
    cheers_posts = current_member.cheers_posts
    # 投稿一覧を自分がCheersしている投稿に絞り込み
    post_search = params[:post_search]
    # 投稿検索で受け取った値を代入
    if post_search != nil
    #検索から遷移したら
      @posts = cheers_posts.where("content like ?", "%#{post_search}%").order(id: :desc)
    else
      @posts = cheers_posts.order(id: :desc)
    end
  end
  
  def group_list
    group_search = params[:group_search]
    # グループ検索で受け取った値を代入
    if group_search != nil
    #検索から遷移したら
      groups = current_member.groups.where("name like ?", "%#{group_search}%").includes(:members).sort {|a,b| b.members.size <=> a.members.size}
      @groups = Kaminari.paginate_array(groups).page(params[:page]).per(10)
    else
      groups = current_member.groups.includes(:members).sort {|a,b| b.members.size <=> a.members.size}
      @groups = Kaminari.paginate_array(groups).page(params[:page]).per(10)
    end
  end

end