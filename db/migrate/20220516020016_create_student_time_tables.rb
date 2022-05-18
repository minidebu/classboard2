class CreateStudentTimeTables < ActiveRecord::Migration[6.0]
  def change
    create_table :student_time_tables do |t|
      t.references  :student,null: false ,foreign_key: true
      t.references  :time_table,null: false ,foreign_key: true
      t.date        :started_on ,null:false 
      t.timestamps
    end
  end
end
