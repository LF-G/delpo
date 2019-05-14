class RemoveColumnHistAcepAtualFromAcepcoes < ActiveRecord::Migration[5.2]
  def change
    remove_column :acepcoes, :histacepatual_id, :integer
  end
end
