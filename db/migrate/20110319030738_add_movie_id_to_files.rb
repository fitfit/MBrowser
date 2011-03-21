class AddMovieIdToFiles < ActiveRecord::Migration
  def self.up
    add_column :system_files, :movie_id, :integer
  end

  def self.down
    remove_column :system_files, :movie_id
  end
end
