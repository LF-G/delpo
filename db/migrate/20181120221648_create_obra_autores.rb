class CreateObraAutores < ActiveRecord::Migration[5.2]
  def change
    create_table :obra_autores do |t|
      t.references :obra, foreign_key: true
      t.references :autor, foreign_key: true
      t.string :tipo, limit: 20
      t.boolean :incerteza

      t.timestamps
    end
  end
end
