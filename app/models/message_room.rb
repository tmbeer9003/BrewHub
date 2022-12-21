class MessageRoom < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :members, through: :entries, source: :member
  has_many :messages, dependent: :destroy
end