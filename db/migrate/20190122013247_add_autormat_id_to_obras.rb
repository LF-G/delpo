class AddAutormatIdToObras < ActiveRecord::Migration[5.2]
  def change
    add_column :obras, :autormat_id, :integer
  end
end
