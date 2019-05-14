class AddColumnSessaoToResultados < ActiveRecord::Migration[5.2]
  def change
    add_reference :resultados, :sessao, foreign_key: true, null: false
  end
end
