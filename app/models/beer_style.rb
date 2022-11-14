class BeerStyle < ApplicationRecord
  has_many :beers, dependent: :destroy

  enum category: { lager: 0, ale: 1 }
end
