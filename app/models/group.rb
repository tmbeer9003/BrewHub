class Group < ApplicationRecord
  belongs_to :owner, class_name: 'Member'
  has_many :groups_members, dependent: :destroy
  has_many :members, through: :groups_members, source: :member
  has_many :group_posts, dependent: :destroy

  has_one_attached :group_image


  def get_group_image(width, height)
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/post-no-image.jpg')
      group_image.attach(io: File.open(file_path), filename: 'post-default-image.jpg', content_type: 'image/jpeg')
    end
    group_image.variant(resize_to_limit: [width, height]).processed
  end
  
end
