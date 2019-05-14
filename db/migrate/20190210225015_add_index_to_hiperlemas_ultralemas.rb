class AddIndexToHiperlemasUltralemas < ActiveRecord::Migration[5.2]
  def change
    add_index :hiperlemas_ultralemas, :hiperlema_id
    add_index :hiperlemas_ultralemas, :ultralema_id
  end
end
