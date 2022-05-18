class ScheduleTimeTablesController < ApplicationController
  def index
    @student = Student.find(params[:student_id])
    @stt = ScheduleTimeTable.set(@student)
  end



  def create
    stt = ScheduleTimeTable.new(stt_params)
    if stt.valid? & stt.save
        redirect_to root_path
    else
      @student = Student.find(params[:student_id])
      @stt = ScheduleTimeTable.set(@student)  
      render :index
    end

  end 

  private 
  def stt_params
    params.require(:schedule_time_table).permit(:schedule_id,:time_table_id,:week_id,:st_time,:started_on).merge(student_id:params[:student_id])
  end

end
