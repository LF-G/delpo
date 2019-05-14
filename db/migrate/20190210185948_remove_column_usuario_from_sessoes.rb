class RemoveColumnUsuarioFromSessoes < ActiveRecord::Migration[5.2]
  def change
    remove_column :sessoes, :usuario, :integer
  end
end
