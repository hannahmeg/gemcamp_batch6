class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :student_number
      t.string :birthdate
      t.string :timestamps
    end
  end
end
