class StudentsController < ApplicationController
  def index
    @student = Student.new
    
  end
  def create
    @student = Student.new(student_params)
    if @student.save 
      redirect_to root_path
    else
      render action: :index
    end

  end

  private
  def student_params
    params.require(:student).permit(:kana_name,:name,:birth_on)
    
  end
end
