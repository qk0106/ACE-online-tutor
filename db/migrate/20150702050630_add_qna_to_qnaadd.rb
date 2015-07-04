class AddQnaToQnaadd < ActiveRecord::Migration
  def change
    add_reference :qnaadds, :qna, index: true, foreign_key: true
  end
end
