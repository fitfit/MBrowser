class CreateSystemFiles < ActiveRecord::Migration
  def self.up
    create_table :system_files do |t|
      t.string :original_name
      t.string :name
      t.string :file_type
      t.string :path

      t.timestamps
    end
  end

  def self.down
    drop_table :system_files
  end
end
