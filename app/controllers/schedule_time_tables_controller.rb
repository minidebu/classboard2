class ScheduleTimeTablesController < ApplicationController
  def index
    if Schedule.all.blank?
      redirect_to schedules_path
    else
      @student = Student.find(params[:student_id])
      @stt = ScheduleTimeTable.set(@student)
    end
  end
  def create
    @stt = ScheduleTimeTable.new(stt_params)
    if @stt.valid? & @stt.save
        redirect_to root_path
    else
      @student = Student.find(params[:student_id])
      @stt.started_on = Date.new(@stt.started_on[1],@stt.started_on[2] ,@stt.started_on[3])
      @stt.schedule_id = @stt.schedule_id.to_i
      render :index
    end

  end 

  private 
  def stt_params
    params.require(:schedule_time_table).permit(:schedule_id,:time_table_id,:week_id,:st_time,:started_on).merge(student_id:params[:student_id])
  end

end
