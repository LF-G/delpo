class CreateObraEditorasJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :obra_editoras, id: false do |t|
      t.belongs_to :obra, index: true
      t.belongs_to :editora, index: true
    end
  end
end
