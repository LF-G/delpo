class AddColumnUsuarioToSessao < ActiveRecord::Migration[5.2]
  def change
    add_column :sessoes, :usuario, :integer
  end
end
