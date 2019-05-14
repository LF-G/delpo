class CreateObras < ActiveRecord::Migration[5.2]
  def change
    create_table :obras do |t|
      t.belongs_to :autor, foreign_key: true
      t.integer :organizador_id
      t.integer :editor_id
      t.belongs_to :editora, foreign_key: true
      t.date :texto_data
      t.string :texto_data_real
      t.date :publicao_data
      t.string :publicacao_data_real
      t.text :texto_titulo
      t.text :publicacao_titulo
      t.text :texto_local
      t.string :localiz
      t.string :edicao_numero
      t.string :edicao_volume
      t.string :edicao_tipo
      t.string :cota
      t.string :univdisc
      t.string :genero
      t.string :suporte
      t.string :concedente
      t.text :comentarios
      t.integer :moedor

      t.timestamps
    end
  end
end
