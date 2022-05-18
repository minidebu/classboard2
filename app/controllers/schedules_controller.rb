class SchedulesController < ApplicationController
  def index
    @schedule = Schedule.new
    @schedules =Schedule.all
  end

  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule .save 
      redirect_to schedules_path
    else
      @schedules = Schedule.all
      render action: :index 
    end
  end

  private
  def schedule_params
    params.require(:schedule).permit(:one_week_id,:two_week_id,:three_week_id,:four_week_id)
  end
end
