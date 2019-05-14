class ChangeObrasColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :obras, :publicao_data, :publicacao_data
  end
end
