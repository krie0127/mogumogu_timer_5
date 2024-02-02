class CreateStopwatches < ActiveRecord::Migration[7.1]
  def change
    create_table :stopwatches do |t|
      t.datetime :start_time, null: false
      t.datetime :end_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
