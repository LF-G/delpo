class CreateFlexoes < ActiveRecord::Migration[5.2]
  def change
    create_table :flexoes do |t|
      t.references :acepcao, foreign_key: true
      t.bigint :histflexaoatual_id
      t.string :flexao, limit: 50
      t.timestamps
    end
  end
end
