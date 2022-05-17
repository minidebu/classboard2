
class ScheduleTimeTable
include ActiveModel::Model
include ActiveRecord::AttributeAssignment 
attr_accessor :student_id,:schedule_id,:started_on,:time_table_id,:week_id,:st_time,:name



def self.set(student)
  if student.schedules.blank? && student.time_tables.blank?
    ScheduleTimeTable.new(name:student.name)
  elsif  student.schedules.present? && student.time_tables.present?  
    schedule = student.schedules.last
    time_table = student.time_tables.last
    ScheduleTimeTable.new(student_id: student.id,schedule_id:schedule.id,time_table_id:time_table.id,week_id:time_table.week_id,st_time:time_table.st_time,name:student.name)
  end

end

  def save
    
    binding.pry

  end

  def schedule_save

  end

end