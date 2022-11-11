class BeerStyle < ApplicationRecord
  
  enum category: { lager: 0, ale: 1 }
  
end
