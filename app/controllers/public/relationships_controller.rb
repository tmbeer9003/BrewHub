class Public::RelationshipsController < ApplicationController
  before_action :set_member

  def create
    current_member.follow(@member)
    redirect_to request.referrer, notice: "#{@member.display_name}さんをフォローしました"
  end

  def destroy
    current_member.unfollow(@member)
    redirect_to request.referrer, warning: "#{@member.display_name}さんのフォローを解除しました"
  end

  def followings
    member_search = params[:member_search]
    # 会員検索で受け取った値を代入
    unless member_search.nil?
      @members = @member.followings.where("account_name like ?", "%#{member_search}%").page(params[:page]).per(10)
    else
      @members = @member.followings.page(params[:page]).per(10)
    end
  end

  def followers
    member_search = params[:member_search]
    # 会員検索で受け取った値を代入
    unless member_search.nil?
      @members = @member.followers.where("account_name like ?", "%#{member_search}%").page(params[:page]).per(10)
    else
      @members = @member.followers.page(params[:page]).per(10)
    end
  end

  private
    def set_member
      @member = Member.find(params[:member_id])
    end
end
