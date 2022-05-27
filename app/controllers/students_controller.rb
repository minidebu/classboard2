
class StudentsController < ApplicationController
  def index
    @students = Student.all
  end
  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save 
      redirect_to student_path(@student[:id])
    else
      
      render action: :new
    end
  end

  def show
    @student = Student.find(params[:id])
  end  

  def update
    @student = Student.find(params[:id])
    if @student.update(withdrawal_on:withdrawal_params)
      redirect_to root_path
    else 
      render action: :show
    end
    
  end

  private
  
  def student_params
    params.require(:student).permit(:kana_name,:name,:birth_on)
  end
    
  def withdrawal_params
    date = params.require(:student).permit(:withdrawal_on)

    if date["withdrawal_on(1i)"].empty? || date["withdrawal_on(2i)"].empty? || date["withdrawal_on(3i)"].empty?
      return
    end
    Date.new(date["withdrawal_on(1i)"].to_i,date["withdrawal_on(2i)"].to_i,date["withdrawal_on(3i)"].to_i)
  end

  def plan_params 
    params.require(:student).permit(:name, plans_attributes: [:id, :week_id,:num_week_id,:st_time,:started_on,:lesson_id,:_destroy])
  end
end
