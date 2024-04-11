class StudentsController < ApplicationController
  def index
    @student = Student.all
    @phone_number = PhoneNumber.all
  end
end
