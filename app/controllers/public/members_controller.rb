class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest, only: [:edit, :update]

  def index
    member_search = params[:member_search]
    # 会員検索で受け取った値を代入
    unless member_search.nil?
      @members = Member.all.page(params[:page]).per(10)
    else
      @members = Member.where("account_name like ?", "%#{member_search}%").page(params[:page]).per(10)
    end
  end

  def show
    @member = Member.find(params[:id])
    post_search = params[:post_search]
    # 投稿検索で受け取った値を代入
    unless post_search.nil?
      @posts = @member.posts.where("content like ?", "%#{post_search}%").order(id: :desc).page(params[:page]).per(7)
    else
      @posts = @member.posts.order(id: :desc).page(params[:page]).per(7)
    end
  end

  def edit
    @member = current_member
    @beer_styles = BeerStyle.all
  end

  def update
    @member = current_member
    @beer_styles = BeerStyle.all
    render "edit" if @member.update(member_params)
  end

  private

  def member_params
    params.require(:member).permit(:account_name, :display_name, :email, :member_image, :introduction, :my_beer_style1_id, :my_beer_style2_id, :my_beer_style3_id, :my_beer_style4_id)
  end

  def ensure_guest
    redirect_to mypage_path, alert: "権限がありません" if current_member.account_name == "guestuser"
  end
end
