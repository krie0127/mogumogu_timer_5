class Stopwatch < ApplicationRecord
  belongs_to :user
  MEAL_TYPES = %w[breakfast lunch dinner]

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :meal_type, inclusion: { in: MEAL_TYPES }
end
