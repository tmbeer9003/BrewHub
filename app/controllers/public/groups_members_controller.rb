class Public::GroupsMembersController < ApplicationController
  before_action :set_group_member

  def create
    groups_member = @group.groups_members.new(member_id: current_member.id)
    if groups_member.save
      redirect_to group_path(@group)
    end
  end

  def destroy
    groups_member = @group.groups_members.find_by(member_id: current_member.id)
    if groups_member.destroy
      redirect_to groups_path
    end
  end
  
  private
  
  def set_group_member
    @group = Group.find(params[:group_id])
  end
end
