class Public::GroupsMembersController < ApplicationController
  before_action :set_group_member
  before_action :authenticate_member!


  def create
    groups_member = @group.groups_members.new(member_id: current_member.id)
    redirect_to group_path(@group), notice: "グループに参加しました" if groups_member.save
  end

  def destroy
    groups_member = @group.groups_members.find_by(member_id: current_member.id)
    redirect_to groups_path, warning: "グループを退会しました" if groups_member.destroy
  end

  private

  def set_group_member
    @group = Group.find(params[:group_id])
  end
end
