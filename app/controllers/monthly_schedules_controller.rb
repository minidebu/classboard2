class MonthlySchedulesController < ApplicationController
  def index
    @monthly_schedule = MonthlySchedule.new
    @monthly_schedules = MonthlySchedule.all
  end



  def create
    @monthly_schedule = MonthlySchedule.new(monthly_schedule_params)
    
    if @monthly_schedule .save 

      redirect_to monthly_schedules_path
    else
      @monthly_schedules = MonthlySchedule.all
      render action: :index 
    end
  end


  private
  def monthly_schedule_params
    params.require(:monthly_schedule).permit(:one_week_id,:two_week_id,:three_week_id,:four_week_id)
  end
end
