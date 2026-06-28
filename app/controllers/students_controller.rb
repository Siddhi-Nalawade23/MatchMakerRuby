class StudentsController < ApplicationController

    def index
        @students = Student.all
    end


    def show 
        @student = Student.find(params[:id])
    end   

    def destroy
      @student= Student.find(params[:id])
      @student.destroy
      redirect_to students_path, notice: "Student deleted successfully."
    end 
    def new
    @student = Student.new
    end

   def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to students_path, notice: "Student created successfully."
    else
      render :new, status: :unprocessable_entity
    end
    end

    def edit 
    @student=Student.find(params[:id])
    end   
    
    def update
    @student=Student.find(params[:id])
    if @student.update(student_params)
      redirect_to students_path, notice: "Student updated successfully."
      
    else
      render :edit, status: :unprocessable_entity
    end
    end


    private
    def student_params
        params.require(:student).permit(:first_name, :last_name, :email)
    end
end 
