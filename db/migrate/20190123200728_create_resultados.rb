class CreateResultados < ActiveRecord::Migration[5.2]
  def change
    create_table :resultados do |t|
      t.date :taq
      t.integer :classificacao
      t.string :metalema, null: false
      t.integer :sessao, null: false
      t.boolean :ativo, null: false

      t.timestamps
    end
  end
end
