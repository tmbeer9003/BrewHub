class Public::MembersController < ApplicationController
  before_action :authenticate_member!

  def index
    member_search = params[:member_search]
    # 会員検索で受け取った値を代入
    member_search.present? ? (members = Member.where("account_name like ?", "%#{member_search}%")) : (members = Member.all)
    @members = members.page(params[:page]).per(10)
  end

  def show
    @member = Member.find(params[:id])
    post_search = params[:post_search]
    # 投稿検索で受け取った値を代入
    post_search.present? ? (posts = @member.posts.where("content like ?", "%#{post_search}%")) : (posts = @member.posts)
    @posts = posts.order(id: :desc).page(params[:page]).per(7)
  end

  def edit
    @member = current_member
    @beer_styles = BeerStyle.all
  end

  def update
    @member = current_member
    @beer_styles = BeerStyle.all
    @member.update(member_params) ? (redirect_to mypage_edit_path, notice: "会員情報を変更しました") : (render "error")
  end

  private
    def member_params
      params.require(:member).permit(:account_name, :display_name, :email, :member_image, :introduction, :my_beer_style1_id, :my_beer_style2_id, :my_beer_style3_id, :my_beer_style4_id)
    end
end
