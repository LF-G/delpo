class AddReferenceToColumnHistAcepAtualOfAcepcoes < ActiveRecord::Migration[5.2]
  def change
    add_reference :acepcoes, :histacepatual_id, references: :historicoacepcoes, index: true
  end
end
