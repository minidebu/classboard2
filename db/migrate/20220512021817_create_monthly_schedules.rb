class CreateMonthlySchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :monthly_schedules do |t|
      t.references  :one_week,null: false ,foreign_key: { to_table: :lessons}
      t.references  :two_week,null: false ,foreign_key: { to_table: :lessons}
      t.references  :three_week,null: false ,foreign_key: { to_table: :lessons}
      t.references  :four_week,null: false ,foreign_key: { to_table: :lessons}
    end
  end
end


