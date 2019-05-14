class RemoveColumnSessaoFromResultados < ActiveRecord::Migration[5.2]
  def change
    remove_column :resultados, :sessao, :integer
  end
end
