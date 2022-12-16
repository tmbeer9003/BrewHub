class PostComment < ApplicationRecord
  belongs_to :member
  belongs_to :post

  validates :content, presence: true, length: { maximum: 200 }
end
