class CreateDatacoes < ActiveRecord::Migration[5.2]
  def change
    create_table :datacoes do |t|
      t.references :usuario, null: false
      t.references :ocorrencia, null: false
      t.integer :anterior_id
      t.integer :moderador_id
      t.datetime :horario, null: false
      t.timestamps
    end
  end
end
