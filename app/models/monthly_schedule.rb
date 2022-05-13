class MonthlySchedule < ApplicationRecord
  belongs_to :one_week, class_name: "Lesson"
  belongs_to :two_week, class_name: "Lesson"
  belongs_to :three_week, class_name: "Lesson"
  belongs_to :four_week, class_name: "Lesson"

  has_many :student_monthlies
  has_many :students, through: :student_monthlies
end
