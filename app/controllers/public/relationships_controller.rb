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
    # 会員検索で受け取った値を代入
    member_search = params[:member_search]
    if member_search.present?
      members = @member.followings.where("account_name like ?", "%#{member_search}%")
    else
      members = @member.followings
    end
    @members = members.page(params[:page]).per(10)
  end

  def followers
    # 会員検索で受け取った値を代入
    member_search = params[:member_search]
    if member_search.present?
      members = @member.followers.where("account_name like ?", "%#{member_search}%")
    else
      members = @member.followers
    end
    @members = members.page(params[:page]).per(10)
  end

  private
    def set_member
      @member = Member.find(params[:member_id])
    end
end
