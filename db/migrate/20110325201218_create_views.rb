class CreateViews < ActiveRecord::Migration
  def self.up
    create_table :views do |t|
      t.string :name

      t.timestamps
    end
    create_table :movies_views, :id =>false do |t|
      t.integer :movie_id
      t.integer :view_id
    end

  end

  def self.down
    drop_table :views
    drop_table :movies_views
  end
end
