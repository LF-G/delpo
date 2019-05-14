class MudaTabelaUsuarios < ActiveRecord::Migration[5.2]
  def change
    change_column :usuarios, :level, :string, :null => false
    change_column :usuarios, :username, :string, :unique => true, :null => false
    change_column :usuarios, :nome, :string, :null => false
  end
end
