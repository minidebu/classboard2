class Schedule < ApplicationRecord
  belongs_to :one_week, class_name: "Lesson"
  belongs_to :two_week, class_name: "Lesson"
  belongs_to :three_week, class_name: "Lesson"
  belongs_to :four_week, class_name: "Lesson"

  has_many :student_schedules
  has_many :students, through: :student_schedules
end
