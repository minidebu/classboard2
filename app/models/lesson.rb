class Lesson < ApplicationRecord
  has_many :plans
  has_many :monthly_schedules
end
