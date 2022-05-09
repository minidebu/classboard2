# require 'happybirthday'
class StudentsController < ApplicationController
  def index
    @student = Student.new
    @students = Student.all
  end
  def create
    @student = Student.new(student_params)
    if @student.save 
      redirect_to student_path(@student[:id])
    else
      @students = Student.all
      render action: :index 
    end
  end

  def show
    @student = Student.find(params[:id])
  end  

  def update
    @student = Student.find(params[:id])
    @student.withdrawal_on =  withdrawal_params  
    if @student.valid?(:withdrawal_set)
      @student.save
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
end
