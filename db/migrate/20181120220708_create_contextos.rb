class CreateContextos < ActiveRecord::Migration[5.2]
  def change
    create_table :contextos do |t|
      t.references :obra, foreign_key: true
      t.string :conteudo, limit: 2048
      t.boolean :fake

      t.timestamps
    end
  end
end
