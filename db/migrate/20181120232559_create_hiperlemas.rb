class CreateHiperlemas < ActiveRecord::Migration[5.2]
  def change
    create_table :hiperlemas do |t|
      t.bigint :principal_id
      t.string :hiperlema, limit: 50

      t.timestamps
    end
  end
end
