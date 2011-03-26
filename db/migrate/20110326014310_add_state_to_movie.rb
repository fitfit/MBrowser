class AddStateToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :state, :string
  end

  def self.down
    remove_column :movies, :state
  end
end
