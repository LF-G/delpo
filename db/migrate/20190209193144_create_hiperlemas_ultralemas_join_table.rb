class CreateHiperlemasUltralemasJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :hiperlemas_ultralemas, id: false do |t|
      t.integer :hiperlema_id, null: false
      t.integer :ultralema_id, null: false
    end
  end
end
