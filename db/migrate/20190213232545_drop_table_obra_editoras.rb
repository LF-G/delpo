class DropTableObraEditoras < ActiveRecord::Migration[5.2]
  def change
    drop_table :obra_editoras
  end
end
