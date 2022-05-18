
class ScheduleTimeTable
include ActiveModel::Model
include ActiveRecord::AttributeAssignment 
attr_accessor :student_id,:schedule_id,:started_on,:time_table_id,:week_id,:st_time,:name
with_options presence: true do
  validates :student_id
  validates :started_on
  validates :week_id
  validates :st_time
end

validate :not_afetr_start


  def self.set(student)
    if student.schedules.blank? && student.time_tables.blank?
      ScheduleTimeTable.new(name:student.name,schedule_id:Schedule.first.id)
    elsif  student.schedules.present? && student.time_tables.present?  
      schedule = student.student_schedules.last
      time_table = student.student_time_tables.last.time_table
    

      ScheduleTimeTable.new(student_id: student.id,schedule_id:schedule.schedule_id,time_table_id:time_table.id,week_id:time_table.week_id,st_time:time_table.st_time,name:student.name)
    end

  end

  def save
    if (schedule_save? & time_table_save?)

      return false
    else
      return true
    end
  end


  private
  def not_afetr_start
    student = Student.find(student_id)
    before_on = student.student_schedules.last.started_on
    if  before_on > student.student_time_tables.last.started_on
      before_on = student.student_time_tables.last.started_on
    end
    after_on = Date.new(started_on[1],started_on[2] , started_on[3])  
     if after_on <= before_on
      errors.add(:started_on, 'Please set afetr day ')
     else
      false
     end
  end



  # def not_chenge_time_table
  #   student = Student.find(student_id)

  #   if student.student_time_tables.present? & student.student_schedules.present? 
  #     time_table = student.student_time_tables.last.time_table
  #     schedule = student.student_schedules.last

  #     errors.add(:time_table_id, 'Please change week or time ') if  (st_time[4] ==  time_table.st_time.hour && st_time[5]== time_table.st_time.min && week_id.to_i == time_table.week_id)
  #     errors.add(:schedule_id, 'Please change course ') if  (schedule_id.to_i == schedule.schedule_id )
  #     end

  # end



  def schedule_save?
    student = Student.find(student_id)

    if student.student_schedules.present? 
      schedule = student.student_schedules.last
      upstart_on = Date.new(started_on[1],started_on[2] , started_on[3])  
      if (schedule_id.to_i == schedule.schedule_id  || schedule.started_on >= upstart_on)
        return true
      end
    end
    StudentSchedule.create(student_id: student_id, schedule_id: schedule_id,started_on:started_on)
    return false
  end


  def time_table_save?  
    student = Student.find(student_id)
    upstart_on = Date.new(started_on[1],started_on[2] , started_on[3])
      
      # student_time_tableがある 
    if student.student_time_tables.present?
      time_table = student.time_tables.last
      stime_table=time_table.student_time_tables[0]

      # 開始日が前の日付より古いか、変化がない場合 更新しない
      if stime_table.started_on >= upstart_on  || (
        st_time[4] ==  time_table.st_time.hour && st_time[5]== time_table.st_time.min && week_id.to_i == time_table.week_id)
      return true
      end
    end

    # time_tableに重複があればレコードを取得
    time_present = TimeTable.find_by(st_time:st_time,week_id:week_id)

    # time_tableに重複があれば、student_time_tableを作りつなげる
    if time_present.present?
      StudentTimeTable.create(student_id: student_id, time_table_id: time_present.id,started_on:started_on)
    else
      new_time_table = TimeTable.create(week_id:week_id,st_time:st_time)
      StudentTimeTable.create(student_id: student_id, time_table_id: new_time_table.id,started_on:started_on)      
    end
    return false
  end
end