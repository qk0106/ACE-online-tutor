class AddCourseToCategory < ActiveRecord::Migration
  def change
    add_reference :categories, :course, index: true, foreign_key: true
  end
end
