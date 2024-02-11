class AddMealTypeToStopwatches < ActiveRecord::Migration[7.1]
  def change
    add_column :stopwatches, :meal_type, :string
  end
end
