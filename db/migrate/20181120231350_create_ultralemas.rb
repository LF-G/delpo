class CreateUltralemas < ActiveRecord::Migration[5.2]
  def change
    create_table :ultralemas do |t|
      t.bigint :remota
      t.string :ultralema, limit: 50
      t.string :lingua, limit: 50
      t.string :comentario, limit: 4096
      t.string :assinatura, limit: 200
      t.boolean :ultra_remoto

      t.timestamps
    end
  end
end
