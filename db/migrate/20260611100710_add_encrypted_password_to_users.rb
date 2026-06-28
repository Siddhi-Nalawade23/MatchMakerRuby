class AddEncryptedPasswordToUsers < ActiveRecord::Migration[8.1]
  def change
     add_column :users, :encrypted_password, :string, null: false, default: ""
    remove_column :users, :password_digest, :string
    remove_column :users, :hashed_password, :string
  end
end
