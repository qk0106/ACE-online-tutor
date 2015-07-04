class CreateQnaadds < ActiveRecord::Migration
  def change
    create_table :qnaadds do |t|
      t.text :question
      t.text :answer
      t.string :tag

      t.timestamps null: false
    end
  end
end
