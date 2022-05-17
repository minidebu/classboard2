class StudentSchedulesController < ApplicationController
  def index
    @student = Student.find(params[:student_id])
    @student_schedule = StudentSchedule.new
    @schedules = Schedule.all
    @time_table = TimeTable.new
    @schedule = Schedule.new


  end
  def create

  end




end
