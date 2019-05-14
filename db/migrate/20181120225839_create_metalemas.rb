class CreateMetalemas < ActiveRecord::Migration[5.2]
  def change
    create_table :metalemas do |t|
      t.string :metalema, limit: 50
      t.boolean :ghost

      t.timestamps
    end
  end
end
