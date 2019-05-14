class CreateHemilemas < ActiveRecord::Migration[5.2]
  def change
    create_table :hemilemas do |t|
      t.string :hemilema, limit: 50
      t.string :hemflex, limit: 50

      t.timestamps
    end
  end
end
