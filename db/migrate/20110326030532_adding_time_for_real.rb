class AddingTimeForReal < ActiveRecord::Migration
  def self.up
    add_column :thumbnails, :time, :float


  end

  def self.down
  end
end
