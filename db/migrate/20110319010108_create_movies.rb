class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :name
      t.integer :length
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :movies
  end
end
