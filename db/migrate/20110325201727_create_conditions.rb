class CreateConditions < ActiveRecord::Migration
  def self.up
    create_table :conditions do |t|
      t.string :kind
      t.string :attribute
      t.integer :view_id

      t.timestamps
    end
  end

  def self.down
    drop_table :conditions
  end
end
