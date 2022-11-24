class Public::CheersController < ApplicationController
  before_action :authenticate_member!

  def create
    @post = Post.find(params[:post_id])
    cheer = @post.cheers.new(member_id: current_member.id)
    cheer.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    cheer = @post.cheers.find_by(member_id: current_member.id)
    cheer.destroy
  end
end
