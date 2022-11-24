class Beer < ApplicationRecord
  belongs_to :brewery
  belongs_to :beer_style
  has_many :posts, dependent: :destroy

  validates :name, presence:true, uniqueness: true, length:{maximum:20}
  validates :location, numericality: true, allow_nil: true
  validates :ibu, numericality: true, allow_nil: true
  validates :description, length:{maximum: 500}

  def beer_evaluation
    evaluations_all = self.posts.pluck(:evaluation)
    #beerに紐づけられた投稿のevaluationカラムを配列で取り出す
    evaluations = evaluations_all.compact
    #nilを除く
    evaluations.sum.fdiv(evaluations.length)
    #平均値を算出
  end

end