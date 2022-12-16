class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  layout "application_no_sidebar"

  def index
    post_search = params[:post_search]
    # 投稿検索で受け取った値を代入
    unless post_search
      @posts = Post.all.order(id: :desc).page(params[:page]).per(7)
    else
      @posts = Post.where("content like ?", "%#{post_search}%").order(id: :desc).page(params[:page]).per(7)
    end
  end

  def show
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.order("id DESC").page(params[:page]).per(5)
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
      evaluation = @post.beer.beer_evaluation
      @post.beer.update(evaluation: evaluation)
      redirect_to admin_posts_path, success: "管理者権限で投稿を更新しました"
    else
      render "error"
    end
  end

  def destroy
    @post.update(evaluation: nil)
    # 削除する投稿のevaluationをnilにする（=この後の計算の分母・分子から除く）
    evaluation = @post.beer.beer_evaluation
    @post.beer.update(evaluation: evaluation)
    @post.destroy
    redirect_to admin_posts_path, alert: "管理者権限で投稿を削除しました"
  end

  private
    def post_params
      params.require(:post).permit(:member_id, :beer_id, :bar_id, :shop_id, :content, :evaluation, :serving_style, :post_image)
    end

    def set_post
      @post = Post.find(params[:id])
    end
end
