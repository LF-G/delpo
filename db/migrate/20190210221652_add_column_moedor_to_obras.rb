class AddColumnMoedorToObras < ActiveRecord::Migration[5.2]
  def change
    add_column :obras, :moedor, :boolean
  end
end
