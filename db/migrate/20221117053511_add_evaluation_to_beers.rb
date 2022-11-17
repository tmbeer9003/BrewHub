class AddEvaluationToBeers < ActiveRecord::Migration[6.1]
  def change
    add_column :beers, :evaluation, :float
  end
end
