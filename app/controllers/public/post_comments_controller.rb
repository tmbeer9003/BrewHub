class Public::PostCommentsController < ApplicationController
  before_action :authenticate_member!

  def create
    @post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.new(post_comment_params)
    @post_comment.member_id = current_member.id
    @post_comments = @post.post_comments.order("id DESC").page(params[:page]).per(5)
    render "error" unless @post_comment.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @post_comments = @post.post_comments.order("id DESC").page(params[:page]).per(5)
    @post_comment.destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:member_id, :post_id, :content)
  end
end
