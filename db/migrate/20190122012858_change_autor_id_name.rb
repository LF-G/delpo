class ChangeAutorIdName < ActiveRecord::Migration[5.2]
  def change
    rename_column :obras, :autor_id, :autorint_id
  end
end
