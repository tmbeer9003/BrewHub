class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :cheers, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :relationships, dependent: :destroy
  # フォローしている人のidを取り行く
  has_many :followings, through: :relationships, source: :follow
  # memberがフォローしている人（follow）
  has_many :inverse_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  # 逆の関係（フォローされている人から見た、フォロワーのidを取り行く）
  has_many :followers, through: :inverse_relationships, source: :member
  # followから見たフォロワー（memmber）

  has_one_attached :member_image

  def get_member_image(width, height)
    unless member_image.attached?
      file_path = Rails.root.join('app/assets/images/member-no-image.jpg')
      member_image.attach(io: File.open(file_path), filename: 'member-default-image.jpg', content_type: 'image/jpeg')
    end
    member_image.variant(resize_to_limit: [width, height]).processed
  end

  def follow(member)
    unless self == member
      self.relationships.find_or_create_by(follow_id: member.id)
    end
  end

  def unfollow(member)
    relationship = self.relationships.find_by(follow_id: member.id)
    relationship.destroy
  end

  def followed_already?(member)
    relationships.exists?(follow_id: member.id)
  end
  
  def followed_me?(member)
    self.relationships.exists?(follow_id: member.id)
  end

end
