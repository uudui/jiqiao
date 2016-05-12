class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :remember_token
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :locked_at


      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :username, unique: true

  end
end
