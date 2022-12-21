class Message < ApplicationRecord
  belongs_to :member
  belongs_to :message_room

  validates :content, presence: true, length: { maximum: 100 }
end
