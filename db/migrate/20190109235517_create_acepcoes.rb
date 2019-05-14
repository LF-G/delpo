class CreateAcepcoes < ActiveRecord::Migration[5.2]
  def change
    create_table :acepcoes do |t|
      t.references :metalema, foreign_key: true
      t.references :hiperlema, foreign_key: true
      t.bigint :histacepatual_id
      t.string :acepcao, limit: 50
      t.string :imagem, limit: 50
      t.string :fonte_imagem, limit: 50
      t.boolean :ghost
      t.timestamps
    end
  end
end
