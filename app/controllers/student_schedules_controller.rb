class StudentSchedulesController < ApplicationController
  def index
    @student = Student.find(params[:student_id])
    @student_schedule = StudentSchedule.new
    @schedules = Schedule.all
  end
  def create
    binding.pry 

  end




end
