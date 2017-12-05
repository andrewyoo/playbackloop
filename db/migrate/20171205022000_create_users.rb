class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: true
      t.string :name
      t.string :username
      t.string :access_token
      t.string :refresh_token
      t.string :avatar_url
      t.datetime :deleted_at
      t.timestamps
      t.index :username, unique: true
    end
  end
end
