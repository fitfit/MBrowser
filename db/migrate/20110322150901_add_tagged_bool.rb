class AddTaggedBool < ActiveRecord::Migration
  def self.up
    add_column :movies, :tagged, :boolean, :default => 0
  end

  def self.down
  end
end
