class AddColumnHistFlexAtualToFlexoes < ActiveRecord::Migration[5.2]
  def change
    add_reference :flexoes, :histflexatual, foreign_key: {to_table: :historicoflexoes}
  end
end
