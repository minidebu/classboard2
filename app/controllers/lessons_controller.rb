class LessonsController < ApplicationController

  def create
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      redirect_to root_path
    else
      @schedule = Schedule.new
      render "schedules/index"
    end
  end

  def destroy
    lesson = Lesson.find(params[:id])
    lesson.destroy
    redirect_to root_path

  end


  private
  def lesson_params
    params.require(:lesson).permit(:name)
  end
end
