class RemoveColumnHistFlexAtualFromFlexoes < ActiveRecord::Migration[5.2]
  def change
    remove_column :flexoes, :histflexatual_id, :integer
  end
end
