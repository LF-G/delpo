class CreateUsuarios < ActiveRecord::Migration[5.2]
  def change
    create_table :usuarios do |t|
      t.integer :level
      t.string :username
      t.string :password_digest
      t.string :email
      t.string :nome
      t.string :instituicao
      t.string :lattes
      t.string :abreviatura
      t.boolean :filologia, :default => false
      t.boolean :edicao, :default => false
      t.boolean :programador, :default => false
      t.boolean :produtivo, :default => false

      t.timestamps
    end
  end
end
