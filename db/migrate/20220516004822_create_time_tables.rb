class CreateTimeTables < ActiveRecord::Migration[6.0]
  def change
    create_table :time_tables do |t|
      t.integer     :week_id    ,foreign_key: true ,null: false
      t.time        :st_time    ,null:false 
      t.date        :started_on ,null:false 
      t.timestamps 
    end
  end
end
