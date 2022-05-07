class LessonsController < ApplicationController

  def create
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      redirect_to root_path
    else
      render "plans/index"
    end
  end


  private
  def lesson_params
    binding.pry
    params.require(:lesson).permit(:name)

  end
end
