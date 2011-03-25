class ChangeColumnName < ActiveRecord::Migration
  def self.up
    rename_column :conditions, :attribute, :attr
  end

  def self.down
  end
end
