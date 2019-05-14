class ChangeColNameHistAcep < ActiveRecord::Migration[5.2]
  def change
    rename_column :historicoacepcoes, :acepcao_classemant, :acepcao_classsemant
  end
end
