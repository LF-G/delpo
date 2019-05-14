class RemoveColumnHistAcepAtualIdFromAcepcoes < ActiveRecord::Migration[5.2]
  def change
    remove_column :acepcoes, :histacepatual_id_id, :references
  end
end
