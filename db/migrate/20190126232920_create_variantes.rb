class CreateVariantes < ActiveRecord::Migration[5.2]
  def change
    create_table :variantes do |t|
      t.references :flexao, foreign_key: true
      t.integer :ocorrenciataq_id
      t.string :variante

      t.timestamps
    end
  end
end
