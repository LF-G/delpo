class CreateNewAcepcoesUltralemasJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :acepcoes_ultralemas, id: false do |t|
      t.belongs_to :acepcao, index: true
      t.belongs_to :ultralema, index: true
    end
  end
end
