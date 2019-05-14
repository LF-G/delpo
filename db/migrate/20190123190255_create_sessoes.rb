class CreateSessoes < ActiveRecord::Migration[5.2]
  def change
    create_table :sessoes do |t|
      t.references :usuario, foreign_key: true
      t.datetime :data, null: false
      t.string :relatorio, null: false
      t.references :obra, foreign_key: true
      t.boolean :mostrar, null: false

      t.timestamps
    end
  end
end
