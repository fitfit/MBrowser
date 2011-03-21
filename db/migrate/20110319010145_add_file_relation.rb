class AddFileRelation < ActiveRecord::Migration
  def self.up
    add_column :system_files, :storable_id, :integer
    add_column :system_files, :storable_type, :integer
  end

  def self.down
    remove_column :system_files, :storable_id
    remove_column :system_files, :storable_type
  end
end
