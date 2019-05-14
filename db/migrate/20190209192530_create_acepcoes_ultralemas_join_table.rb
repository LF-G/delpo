class CreateAcepcoesUltralemasJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :acepcoes_ultralemas, id: false do |t|
      t.integer :acep_id
      t.integer :ultra_id
    end
  end
end
