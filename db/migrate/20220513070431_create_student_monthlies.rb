class CreateStudentMonthlies < ActiveRecord::Migration[6.0]
  def change
    create_table :student_monthlies do |t|
      t.references  :student,null: false ,foreign_key: true
      t.references  :monthly_schedule,null: false ,foreign_key: true
      t.date        :started_on ,null:false 

      t.timestamps
    end
  end
end
