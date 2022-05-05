# require 'happybirthday'
class StudentsController < ApplicationController
  def index
    @student = Student.new
    @students = Student.all
  end
  def create
    @student = Student.new(student_params)
    if @student.save 
      redirect_to root_path
    else
      @students = Student.all
      render action: :index 
    end
  end

  def show
    @student = Student.find(params[:id])
  end  

  def update
    student = Student.find(params[:id])
    redirect_to root_path
    
  end

  private
  def student_params
    params.require(:student).permit(:kana_name,:name,:birth_on)
  end
    

end
