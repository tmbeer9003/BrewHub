class Bar < ApplicationRecord
  has_many :posts, dependent: :nullify
  has_many :posts_as_shop, class_name: "Post", foreign_key: "shop_id", dependent: :nullify

  validates :category, presence: true
  validates :place_name, presence: true

  enum category: { bar: 0, shop: 1 }
end
