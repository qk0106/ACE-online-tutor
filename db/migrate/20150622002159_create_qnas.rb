class CreateQnas < ActiveRecord::Migration
  def change
    create_table :qnas do |t|
      t.text :question
      t.text :answer
      t.string :answered_by
      t.datetime :date_post
      t.datetime :date_answered

      t.timestamps null: false
    end
  end
end
