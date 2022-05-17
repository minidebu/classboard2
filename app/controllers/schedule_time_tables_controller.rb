class ScheduleTimeTablesController < ApplicationController
  def index
    @student = Student.find(params[:student_id])
    @stt = ScheduleTimeTable.set(@student)
  end



  def create
   
  
    @stt = ScheduleTimeTable.new(stt_params)
    binding.pry
    if @stt.valid?
      @stt.save
      redirect_to root_path
    else
      render :index
    end

  end 

  private 

  def stt_params
    params.require(:schedule_time_table).permit(:student_id,:schedule_id,:time_table_id,:week_id,:st_time,:started_on)
  end


end
