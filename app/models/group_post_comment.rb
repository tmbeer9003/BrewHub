class GroupPostComment < ApplicationRecord
  belongs_to :group_post
  belongs_to :member

  validates :content, presence: true, length: { maximum: 200 }
end
