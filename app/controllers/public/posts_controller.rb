class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_member, only: [:edit, :update, :destroy]

  def index
    post_search = params[:post_search]
    # 投稿検索で受け取った値を代入
    member = params[:member_id]
    # ユーザーIDで絞り込まれた際に受け取った値を代入
    if post_search != nil
      @posts = Post.where("content like ?", "%#{post_search}%").order(id: :desc).page(params[:page]).per(7)
    elsif member != nil
      @posts = Post.where(member_id: member).order(id: :desc).page(params[:page]).per(7)
    else
      @posts = Post.all.order(id: :desc).page(params[:page]).per(7)
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
      evaluation = @post.beer.beer_evaluation
      @post.beer.update(evaluation: evaluation)
      redirect_to mypage_path, success: "投稿が完了しました"
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
      evaluation = @post.beer.beer_evaluation
      @post.beer.update(evaluation: evaluation)
      redirect_to mypage_path, success: "投稿を更新しました"
    else
      render "error"
    end
  end

  def destroy
    @post.update(evaluation: nil)
    #削除する投稿のevaluationをnilにする（=この後の計算の分母・分子から除く）
    evaluation = @post.beer.beer_evaluation
    @post.beer.update(evaluation: evaluation)
    @post.destroy
    redirect_to mypage_path, alert: "投稿を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:member_id, :beer_id, :bar_id, :shop_id, :content, :evaluation, :serving_style, :post_image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def ensure_correct_member
    unless @post.member == current_member
      redirect_to mypage_path, alert: "権限がありません"
    end
  end

end
