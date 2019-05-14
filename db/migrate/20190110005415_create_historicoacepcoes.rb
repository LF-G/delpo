class CreateHistoricoacepcoes < ActiveRecord::Migration[5.2]
  def change
    create_table :historicoacepcoes do |t|
      t.bigint :anterior_id
      t.string :acepcao_etimologia, limit: 4096
      t.string :usuario_assinatura, limit: 128
      t.string :definicao, limit: 1024
      t.string :acepcao_classemant, limit: 50
      t.string :acepcao_classmorf, limit: 50
      t.timestamps
    end
  end
end
