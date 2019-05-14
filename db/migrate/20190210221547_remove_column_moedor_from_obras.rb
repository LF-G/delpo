class RemoveColumnMoedorFromObras < ActiveRecord::Migration[5.2]
  def change
    remove_column :obras, :moedor, :integer
  end
end
