class AddSubjectToQna < ActiveRecord::Migration
  def change
    add_reference :qnas, :subject, index: true, foreign_key: true
  end
end
