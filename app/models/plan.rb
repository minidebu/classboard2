class Plan < ApplicationRecord
  belongs_to :lesson
  belongs_to :student

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :week
  belongs_to :num_week
end

