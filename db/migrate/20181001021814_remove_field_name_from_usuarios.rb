class RemoveFieldNameFromUsuarios < ActiveRecord::Migration[5.2]
  def change
    remove_column :usuarios, :email, :string
    remove_column :usuarios, :password_digest, :string
  end
end
