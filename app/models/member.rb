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
  has_many :cheers_posts, through: :cheers, source: :post
  # cheersしている投稿
  has_many :groups_members, dependent: :destroy
  has_many :groups, through: :groups_members, source: :group
  has_many :own_groups, class_name: 'Group', foreign_key: 'owner_id', dependent: :destroy
  has_many :group_posts, dependent: :destroy
  has_many :group_post_comments, dependent: :destroy

  has_one_attached :member_image

  VALID_ACCOUNT_NAME_REGEX = /\A[a-z0-9]+\z/i.freeze

  validates :account_name, presence:true, uniqueness: true, length:{maximum:12}, format: { with: VALID_ACCOUNT_NAME_REGEX, message: 'は半角英数字で入力してください' }
  validates :display_name, presence:true, length:{maximum:12}
  validates :date_of_birth, presence:true
  validate :over_20

  def over_20
    unless date_of_birth == nil
      errors.add(:date_of_birth, '：20歳未満の方の登録はできません') if date_of_birth > Date.tomorrow.ago(20.years)
    end
  end

  def get_member_image(width, height)
    unless member_image.attached?
      file_path = Rails.root.join('public/images/member-no-image.jpg')
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
  #自分が相手を既にフォローしているか確認するメソッド

  def followed_me?(member)
    self.relationships.exists?(follow_id: member.id)
  end
  #自分が相手からフォローされているか確認するメソッド

  def joined_already?(group)
    self.groups_members.exists?(group_id: group.id)
  end
   #グループに参加済か確認するメソッド

  def self.guest
    find_or_create_by!(account_name: 'guestuser', display_name: 'ゲストユーザー', email: 'guest@example.com', date_of_birth: '2000-01-01') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.account_name = "guestuser"
    end
  end


end
