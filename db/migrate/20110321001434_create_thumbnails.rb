class CreateThumbnails < ActiveRecord::Migration
  def self.up
    create_table :thumbnails do |t|
      t.integer :tnable_id
      t.string :tnable_type
      t.integer :order

      t.timestamps
    end
  end

  def self.down
    drop_table :thumbnails
  end
end
