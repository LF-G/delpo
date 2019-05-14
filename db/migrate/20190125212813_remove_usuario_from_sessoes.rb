class RemoveUsuarioFromSessoes < ActiveRecord::Migration[5.2]
  def change
    remove_reference :sessoes, :usuario, foreign_key: true
  end
end
