class GroupPost < ApplicationRecord
  belongs_to :group
  belongs_to :member
  has_many :group_post_comments, dependent: :destroy
end
