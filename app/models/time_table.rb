class TimeTable < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :week

  has_many :student_time_tables
  has_many :students, through: :student_time_tables

  validates :week_id, uniqueness: { scope: :st_time }
  
end
