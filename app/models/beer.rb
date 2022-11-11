class Beer < ApplicationRecord
  belongs_to :beer_style
  belongs_to :brewery
end
