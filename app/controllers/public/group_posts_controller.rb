class Public::GroupPostsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_group
  before_action :set_group_post, only: [:show, :edit, :update, :destroy]
  before_action :ensure_group_member
  before_action :ensure_contributer, only: [:edit, :update, :destroy]

  def create
    @group_post = @group.group_posts.new(group_post_params)
    @group_post.member_id = current_member.id
    @group_post.save ? (redirect_to group_path(@group), success: "トピックを投稿しました") : (render "error")
  end

  def show
    @group_post_comment = GroupPostComment.new
    @group_post_comments = @group_post.group_post_comments.order(id: :desc).page(params[:page]).per(5)
  end

  def new
    @group_post = @group.group_posts.new
  end

  def edit
  end

  def update
    @group_post.update(group_post_params) ?
    (redirect_to group_group_post_path(@group, @group_post), success: "トピックを更新しました") : (render "error")
  end

  def destroy
    @group_post.destroy
    redirect_to group_path(@group), alert: "トピックを削除しました"
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

  def ensure_group_member
    unless current_member.joined_already?(@group)
      redirect_to groups_path
    end
  end
  # グループに加入していない会員がURLからアクションを起こそうとしたとき、グループ一覧画面へリダイレクトさせる

  def ensure_contributer
    unless @group_post.member == current_member
    redirect_to group_path(@group), alert: "権限がありません"
    end
  end

end
