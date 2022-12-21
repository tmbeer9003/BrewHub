class Entry < ApplicationRecord
  belongs_to :message_room
  belongs_to :member
end
