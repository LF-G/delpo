class AddUsuarioToSessoes < ActiveRecord::Migration[5.2]
  def change
    add_reference :sessoes, :usuario, foreign_key: true
  end
end
