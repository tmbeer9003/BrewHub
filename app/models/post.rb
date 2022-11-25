class Post < ApplicationRecord
  belongs_to :member
  belongs_to :beer
  belongs_to :bar, optional: true
  belongs_to :shop, optional: true
  has_many :cheers, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :cheers_members, through: :cheers, source: :member

  has_one_attached :post_image

  validates :content, length:{maximum:500}
  validates :serving_style, presence:true,length:{maximum:200}

  enum serving_style: { draft: 0, can: 1, bottle: 2, others: 3 }

  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('public/images/post-no-image.jpg')
      post_image.attach(io: File.open(file_path), filename: 'post-default-image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  def cheers_already?(member)
    cheers.exists?(member_id: member.id)
  end
end
