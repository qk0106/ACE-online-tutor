class AddCategoryToSubject < ActiveRecord::Migration
  def change
    add_reference :subjects, :category, index: true, foreign_key: true
  end
end
