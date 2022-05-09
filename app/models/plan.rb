class Plan < ApplicationRecord
  belongs_to :lesson
  belongs_to :stundet

  ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :week
  belongs_to :num_week
end

