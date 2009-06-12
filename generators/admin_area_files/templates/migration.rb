class AdminSettingsAndUserFields < ActiveRecord::Migration
  def self.up
    create_table :settings, :force => true do |t|
      t.string :var, :null => false
      t.text   :value, :null => true
      t.timestamps
    end

    change_table(:users) do |t|
      t.string :name, :limit => 128
      t.string :role, :limit => 10
    end
  
  end

  def self.down
    change_table(:users) do |t|
      t.remove :name, :role
    end
    drop_table :settings
  end
end