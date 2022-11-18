class Public::GroupPostsController < ApplicationController
  before_action :set_group_post, only: [:show, :edit, :update, :destroy]

  def create
    @group = Group.find(params[:group_id])
    @group_post = @group.group_posts.new(group_post_params)
    @group_post.member_id = current_member.id
    if @group_post.save
      redirect_to group_path(@group)
    else
      render "error"
    end
  end

  def show
  end

  def new
    @group = Group.find(params[:group_id])
    @group_post = @group.group_posts.new
  end

  def edit
  end

  def update
    if @group_post.update(group_post_params)
      redirect_to group_path(@group)
    else
      render "error"
    end
  end

  def destroy
    @group_post.destroy
  end

  private

  def group_post_params
    params.require(:group_post).permit(:member_id, :group_id, :title, :content)
  end

  def set_group_post
    @group = Group.find(params[:group_id])
    @group_post = GroupPost.find(params[:id])
  end
end
