class SchedulesController < ApplicationController
  def index
    
    @schedule = Schedule.new
    @lesson = Lesson.new
  end

  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule .save 
      redirect_to schedules_path
    else
      @lesson = Lesson.new
      render action: :index 
    end
  end

  private
  def schedule_params
    params.require(:schedule).permit(:one_week_id,:two_week_id,:three_week_id,:four_week_id)
  end
end
