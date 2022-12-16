class BeerStyle < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :registered1_members, class_name: "Member", foreign_key: "my_beer_style1_id", dependent: :nullify
  has_many :registered2_members, class_name: "Member", foreign_key: "my_beer_style2_id", dependent: :nullify
  has_many :registered3_members, class_name: "Member", foreign_key: "my_beer_style3_id", dependent: :nullify
  has_many :registered4_members, class_name: "Member", foreign_key: "my_beer_style4_id", dependent: :nullify

  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :category, presence: true

  enum category: { lager: 0, ale: 1 }
end
