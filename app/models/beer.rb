class Beer < ApplicationRecord
  belongs_to :beer_style
  belongs_to :brewery
  has_many :posts, dependent: :destroy
  
  def beer_evaluation
    evaluations_all = self.posts.pluck(:evaluation)
    #beerに紐づけられた投稿のevaluationカラムを配列で取り出す
    evaluations = evaluations_all.compact
    #nilを除く
    evaluations.sum.fdiv(evaluations.length)
    #平均値を算出
  end
  
  
end