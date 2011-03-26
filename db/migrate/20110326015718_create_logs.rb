class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table :logs do |t|
      t.string :title
      t.string :controller
      t.string :action
      t.string :loggable_type
      t.integer :loggable_id
      t.boolean :read, :default=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :logs
  end
end
