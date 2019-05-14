class AddColumnHistAcepAtualToAcepcoes < ActiveRecord::Migration[5.2]
  def change
    add_reference :acepcoes, :histacepatual, foreign_key: {to_table: :historicoacepcoes}
  end
end
