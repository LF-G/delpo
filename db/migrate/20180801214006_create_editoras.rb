class CreateEditoras < ActiveRecord::Migration[5.2]
  def change
    create_table :editoras do |t|
      t.string :nome
      t.belongs_to :cidade, foreign_key: true

      t.timestamps
    end
  end
end
