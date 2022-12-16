class Admin::GroupPostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_group
  before_action :set_group_post, only: [:show, :edit, :update, :destroy]
  layout "application_no_sidebar"

  def show
    @group_post_comment = GroupPostComment.new
    @group_post_comments = @group_post.group_post_comments.order(id: :desc).page(params[:page]).per(5)
  end

  def edit
  end

  def update
    @group_post.update(group_post_params) ?
    (redirect_to admin_group_group_post_path(@group, @group_post), success: "トピックを更新しました") : (render "error")
  end

  def destroy
    @group_post.destroy
    redirect_to admin_group_path(@group), alert: "トピックを削除しました"
  end

  private
    def group_post_params
      params.require(:group_post).permit(:member_id, :group_id, :title, :content)
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

    def set_group_post
      @group_post = GroupPost.find(params[:id])
    end
end
