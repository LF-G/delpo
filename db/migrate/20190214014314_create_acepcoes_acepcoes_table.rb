class CreateAcepcoesAcepcoesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :acepcoes_acepcoes, id: false do |t|
      t.belongs_to :subordinante, foreign_key: {to_table: :acepcoes}
      t.belongs_to :subordinado, index: true, foreign_key: {to_table: :acepcoes}
      t.boolean :certeza
    end
  end
end
