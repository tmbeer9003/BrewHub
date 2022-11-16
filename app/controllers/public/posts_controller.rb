class Public::PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    post_search = params[:post_search]
    # 投稿検索で受け取った値を代入
    member = params[:member_id]
    # ユーザーIDで絞り込まれた際に受け取った値を代入
    if post_search != nil
      @posts = Post.where("content like ?", "%#{post_search}%").order(id: :desc)
    elsif member != nil
      @posts = Post.where(member_id: member).order(id: :desc)
    else
      @posts = Post.all.order(id: :desc)
    end
  end

  def show
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
    @beer = @post.beer
    @bar = Bar.new
    @shop = Shop.new
    @bars = Bar.all
    @shops = Shop.all
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render "error"
    end
  end

  def destroy
    @post.destroy
    redirect_to request.referer
  end

  private

  def post_params
    params.require(:post).permit(:member_id, :beer_id, :bar_id, :shop_id, :content, :evaluation, :serving_style, :post_image)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
