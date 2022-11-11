class BeerStyle < ApplicationRecord

  has_many :beers

  enum category: { lager: 0, ale: 1 }

end
