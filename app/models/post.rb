class Post < ApplicationRecord
  belongs_to :member
  belongs_to :beer
  belongs_to :bar, optional: true
  belongs_to :shop, class_name: "Bar", optional: true
  has_many :cheers, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :cheers_members, through: :cheers, source: :member

  has_one_attached :post_image

  validates :content, length: { maximum: 500 }
  validates :serving_style, presence: true

  enum serving_style: { draft: 0, can: 1, bottle: 2, others: 3 }, _prefix: true

  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join("public/images/post-no-image.jpg")
      post_image.attach(io: File.open(file_path), filename: "post-default-image.jpg", content_type: "image/jpeg")
    end
    post_image.variant(resize_to_fit: [width, height]).processed
  end

  # 既にcheersしているかを
  def cheers_already?(member)
    cheers.exists?(member_id: member.id)
  end

  # 投稿に紐づくビールの評価を再計算し、再代入
  def reevaluate_beer
    self.beer.update(evaluation: self.beer.beer_evaluation)
  end
end
