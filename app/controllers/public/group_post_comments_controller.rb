class Public::GroupPostCommentsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_group_post
  before_action :ensure_group_member

  def create
    @group_post_comment = @group_post.group_post_comments.new(group_post_comment_params)
    @group_post_comment.member_id = current_member.id
    @group_post_comments = @group_post.group_post_comments.order("id DESC").page(params[:page]).per(5)
    unless @group_post_comment.save
      render "error"
    end
  end

  def destroy
    @group_post_comment = GroupPostComment.find(params[:id])
    @group_post_comments = @group_post.group_post_comments.order("id DESC").page(params[:page]).per(5)
    @group_post_comment.destroy
  end

  private
    def group_post_comment_params
      params.require(:group_post_comment).permit(:member_id, :group_post_id, :content)
    end

    def set_group_post
      @group = Group.find(params[:group_id])
      @group_post = GroupPost.find(params[:group_post_id])
    end

    def ensure_group_member
      unless current_member.joined_already?(@group)
        redirect_to groups_path, alert: "権限がありません"
      end
    end
  # グループに加入していない会員がURLからアクションを起こそうとしたとき、グループ一覧画面へリダイレクトさせる
end
