class PlansController < ApplicationController
  def index
    @lesson = Lesson.new
    @lessons = Lesson.all
  end

  def  new
    @lesson = Lesson.new
  end

  def create
    binding.pry
  end

end
