class StudentsController < ApplicationController
  def index
    @student = Student.all
  end
end
