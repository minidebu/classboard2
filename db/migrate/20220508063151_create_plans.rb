class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.integer     :week_id ,null: false
      t.integer     :num_week_id ,null:false
      t.time        :st_time ,null:false 
      t.date        :started_on ,null:false 
      t.date        :updated_on
      t.references  :student,null: false ,foreign_key: true
      t.references  :lesson,null: false ,foreign_key: true
      t.timestamps
    end
  end
end
