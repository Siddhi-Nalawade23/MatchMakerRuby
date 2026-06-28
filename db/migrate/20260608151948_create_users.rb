class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.text :name
      t.text :email
      t.text :password
      t.text :hashed_password
      t.text :phone
      t.text :refresh_token
      t.timestamp :refresh_token_expiry
      t.text :otp
      t.timestamp :otp_expires_at
      t.timestamp :otp_created_at
      t.boolean :otp_used, default: false
      t.text :role, default: 'admin'
      t.timestamps
    end
       add_index :users, :phone, unique: true
  end
end
