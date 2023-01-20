class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_member, only: [:edit, :update, :destroy]

  def index
    # 投稿検索で受け取った値を代入
    post_search = params[:post_search]
    if post_search.present?
      posts = Post.where("content like ?", "%#{post_search}%")
    else
      posts = Post.all
    end
    @posts = posts.order(id: :desc).page(params[:page]).per(7)
  end

  def show
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.order("id DESC").page(params[:page]).per(5)
  end

  def new
    @post = Post.new
    @beer = Beer.find(params[:selected_beer])
    @bar = Bar.new
    @bars = Bar.where(category: 0)
    @shops = Bar.where(category: 1)
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
      @post.reevaluate_beer
      # 画像が投稿された場合のみセーフサーチの判定を行う
      if @post.post_image.attached?
        judge = Vision.get_image_data(@post.post_image)
        @post.update(is_closed: true) if judge.value?("VERY_LIKELY") || judge.value?("LIKELY")
      end
      redirect_to mypage_path, success: "投稿が完了しました"
    else
      render "error"
    end
  end

  def edit
    @beer = @post.beer
    @bar = Bar.new
    @bars = Bar.where(category: 0)
    @shops = Bar.where(category: 1)
  end

  def update
    if @post.update(post_params)
      @post.reevaluate_beer
      redirect_to mypage_path, success: "投稿を更新しました"
    else
      render "error"
    end
  end

  def destroy
    # 削除する投稿のevaluationをnilにする（=この後の計算の分母・分子から除く）
    @post.update(evaluation: nil)
    @post.reevaluate_beer
    @post.destroy
    redirect_to mypage_path, alert: "投稿を削除しました"
  end

  private
    def post_params
      params.require(:post).permit(:member_id, :beer_id, :bar_id, :shop_id, :content, :evaluation, :serving_style, :post_image, :is_closed)
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def ensure_correct_member
      redirect_to mypage_path, alert: "権限がありません" unless @post.member == current_member
    end
end
