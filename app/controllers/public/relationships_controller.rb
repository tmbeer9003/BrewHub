class Public::RelationshipsController < ApplicationController
  before_action :set_member

  def create
    current_member.follow(@member)
    redirect_to request.referrer
  end

  def destroy
    current_member.unfollow(@member)
    redirect_to request.referrer
  end
  
  def followings
    @members = @member.followings.page(params[:page]).per(10)
  end
  
  def followers
    @members = @member.followers.page(params[:page]).per(10)
  end

  private

  def set_member
    @member = Member.find(params[:member_id])
  end
end