class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string    :name           ,null:false
      t.string    :kana_name       ,null:false           
      t.date      :birth_on       ,null:false
      t.date      :withdrawal_on  
      t.timestamps
    end
  end
end
