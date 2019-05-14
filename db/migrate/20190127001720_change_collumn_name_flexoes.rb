class ChangeCollumnNameFlexoes < ActiveRecord::Migration[5.2]
  def change
    rename_column :flexoes, :histflexaoatual_id, :histflexatual_id
  end
end
