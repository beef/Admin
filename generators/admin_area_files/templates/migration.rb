class CreateSettingsAndUsers < ActiveRecord::Migration
  def self.up
    create_table :settings, :force => true do |t|
      t.string :var, :null => false
      t.text   :value, :null => true
      t.timestamps
    end
    
    create_table(:users) do |t|
      t.string   :email
      t.string   :encrypted_password, :limit => 128
      t.string   :salt,               :limit => 128
      t.string   :token,              :limit => 128
      t.datetime :token_expires_at
      t.boolean  :email_confirmed, :default => false, :null => false
      t.string :name, :limit => 128
      t.string :role, :limit => 10
    end

    add_index :users, [:id, :token]
    add_index :users, :email
    add_index :users, :token
  
  end

  def self.down
    drop_table :users
    drop_table :settings
  end
end