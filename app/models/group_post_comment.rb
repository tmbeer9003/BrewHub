class GroupPostComment < ApplicationRecord
  belongs_to :group_post
  belongs_to :member
end
