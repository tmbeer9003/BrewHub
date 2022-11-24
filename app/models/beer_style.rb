class BeerStyle < ApplicationRecord
  has_many :beers, dependent: :destroy

  validates :name, presence:true, uniqueness: true, length:{maximum:20}
  validates :category, presence:true

  enum category: { lager: 0, ale: 1 }
end
