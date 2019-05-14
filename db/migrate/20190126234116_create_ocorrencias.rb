class CreateOcorrencias < ActiveRecord::Migration[5.2]
  def change
    create_table :ocorrencias do |t|
      t.references :variante, foreign_key: true
      t.references :hemilema, foreign_key: true
      t.references :contexto, foreign_key: true, null: false
      t.string :ocorrencia, null: false
      t.integer :add_direita, null: false
      t.integer :add_esquerda, null: false
      t.integer :iter, null: false

      t.timestamps
    end
  end
end
