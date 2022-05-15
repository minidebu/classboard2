class ChangeMonthlySchedulesToSchedules < ActiveRecord::Migration[6.0]
  def change
    rename_table :monthly_schedules, :schedules
  end
end
