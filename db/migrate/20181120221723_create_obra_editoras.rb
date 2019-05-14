class CreateObraEditoras < ActiveRecord::Migration[5.2]
  def change
    create_table :obra_editoras do |t|
      t.references :editora, foreign_key: true
      t.references :obra, foreign_key: true

      t.timestamps
    end
  end
end
