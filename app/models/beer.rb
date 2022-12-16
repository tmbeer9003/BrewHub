class Beer < ApplicationRecord
  belongs_to :brewery
  belongs_to :beer_style
  has_many :posts, dependent: :destroy
  has_many :purchased_shops, through: :posts, source: :shop
  # 特定のビールが買われたお店のデータを取りに行く
  has_many :drunk_bars, through: :posts, source: :bar
  # 特定のビールが飲まれたお店のデータを取りに行く

  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :abv, numericality: true, allow_nil: true
  validates :ibu, numericality: true, allow_nil: true
  validates :description, length: { maximum: 500 }

  def beer_evaluation
    evaluations_all = self.posts.pluck(:evaluation)
    # beerに紐づけられた投稿のevaluationカラムを配列で取り出す
    evaluations = evaluations_all.compact
    # nilを除く
    evaluations.sum.fdiv(evaluations.length)
    # 平均値を算出
  end
end
