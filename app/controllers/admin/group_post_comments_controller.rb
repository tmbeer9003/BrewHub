class Admin::GroupPostCommentsController < ApplicationController
  before_action :authenticate_admin!
  layout "application_no_sidebar"

  def destroy
    @group = Group.find(params[:group_id])
    @group_post = GroupPost.find(params[:group_post_id])
    @group_post_comment = GroupPostComment.find(params[:id])
    @group_post_comments = @group_post.group_post_comments.order("id DESC").page(params[:page]).per(5)
    @group_post_comment.destroy
  end

  private
    def group_post_comment_params
      params.require(:group_post_comment).permit(:member_id, :group_post_id, :content)
    end
end
