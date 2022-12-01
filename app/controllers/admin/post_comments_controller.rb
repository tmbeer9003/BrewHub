class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @post_comments = @post.post_comments.order("id DESC").page(params[:page]).per(5)
    @post_comment.destroy
  end

end
