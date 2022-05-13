class StudentMonthly < ApplicationRecord
  belongs_to :stundet
  belongs_to :monthly_schedule
end
