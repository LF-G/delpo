class CreateConteudos < ActiveRecord::Migration[5.2]
  def change
    create_table :conteudos, id: false do |t|
      t.string :nome, :null => false
      t.text :conteudo_pt, :null => false
      t.text :conteudo_eng, :null => false
      t.string :atualizado_por, :null => false
      t.date :ultima_atualizacao

      t.timestamps
    end
  end
end
