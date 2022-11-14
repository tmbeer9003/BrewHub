class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy

  has_one_attached :member_image

  def get_member_image(width, height)
    unless member_image.attached?
      file_path = Rails.root.join('app/assets/images/member-no-image.jpg')
      member_image.attach(io: File.open(file_path), filename: 'member-default-image.jpg', content_type: 'image/jpeg')
    end
    member_image.variant(resize_to_limit: [width, height]).processed
  end

end
