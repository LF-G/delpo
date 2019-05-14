class CreateHistoricoflexoes < ActiveRecord::Migration[5.2]
  def change
    create_table :historicoflexoes do |t|
      t.bigint :anterior_id
      t.string :flexao_etimologia, limit: 2048
      t.string :usuario_assinatura, limit: 128
      t.string :flexao_classmorf, limit: 250
      t.integer :flexao_rank
      t.timestamps
    end
  end
end
