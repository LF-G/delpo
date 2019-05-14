class RemoveColumnsFromObraAutores < ActiveRecord::Migration[5.2]
  def change
    remove_column :obra_autores, :id, :integer
    remove_column :obra_autores, :created_at, :timestamp
    remove_column :obra_autores, :updated_at, :timestamp
  end
end
