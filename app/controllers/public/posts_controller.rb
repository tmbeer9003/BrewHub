class Public::PostsController < ApplicationController
  def index
    post_search = params[:post_search]
    if post_search == nil
      @posts = Post.all
    else
      @posts = Post.where("content like ?", "%#{post_search}%")
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.order("id DESC").page(params[:page]).per(5)
  end

  def new
    @post = Post.new
    @beer = Beer.find(params[:selected_beer])
    @bar = Bar.new
    @shop = Shop.new
    @bars = Bar.all
    @shops = Shop.all
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
      redirect_to posts_path
    else
      render "error"
    end
  end

  def edit
    @post = Post.find(params[:id])
    @beer = @post.beer
    @bar = Bar.new
    @shop = Shop.new
    @bars = Bar.all
    @shops = Shop.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path
    else
      render "error"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to request.referer
  end

  private

  def post_params
    params.require(:post).permit(:member_id, :beer_id, :bar_id, :shop_id, :content, :evaluation, :serving_style, :post_image)
  end
end
