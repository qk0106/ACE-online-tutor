class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :post
      t.string :name
      t.datetime :posted_date
      t.datetime :answered_date
      t.string :answered_by

      t.timestamps null: false
    end
  end
end
