class StudentTimeTable < ApplicationRecord
  belongs_to :student
  belongs_to :time_table
end
