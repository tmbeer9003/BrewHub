class GroupPost < ApplicationRecord
  belongs_to :group
  belongs_to :member
  has_many :group_post_comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 200 }
end
