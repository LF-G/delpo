class CreateOcorrenciasResultadosJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :ocorrencias_resultados, id: false do |t|
      t.belongs_to :ocorrencia, index: true
      t.belongs_to :resultado, index: true
    end
  end
end
