class CreateAutores < ActiveRecord::Migration[5.2]
  def change
    create_table :autores do |t|
      t.integer :pseudonimo_id
      t.string :pseudonimo
      t.belongs_to :cidade, foreign_key: true
      t.string :alcunha
      t.string :nome
      t.date :datanasc
      t.string :realnasc
      t.date :datamorte
      t.string :realmorte
      t.string :biografia

      t.timestamps
    end
  end
end
