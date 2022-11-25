class AddMyBeerStyleToMembers < ActiveRecord::Migration[6.1]
  def change
    add_reference :members, :my_beer_style1, foreign_key: { to_table: :beer_styles }
    add_reference :members, :my_beer_style2, foreign_key: { to_table: :beer_styles }
    add_reference :members, :my_beer_style3, foreign_key: { to_table: :beer_styles }
    add_reference :members, :my_beer_style4, foreign_key: { to_table: :beer_styles }
  end
end
