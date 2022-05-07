class PlansController < ApplicationController
  def index
    @lesson = Lesson.new
    @lessons = Lesson.all
  end
end
