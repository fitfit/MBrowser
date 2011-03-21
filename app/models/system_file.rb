class SystemFile < ActiveRecord::Base
  belongs_to :storable, :polymorphic => true
  before_destroy :delete_file

  def delete_file
     if File.exist?(self.path) then FileUtils.remove_file(self.path) end
  end
end
