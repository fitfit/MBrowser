class FixStorableType < ActiveRecord::Migration
  def self.up
    change_column :system_files, :storable_type, :string
  end

  def self.down
  end
end
