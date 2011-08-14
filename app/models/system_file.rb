class SystemFile < ActiveRecord::Base
  belongs_to :storable, :polymorphic => true
  before_destroy :delete_file

  def delete_file
    if File.exist?(self.path) then FileUtils.mv(self.path,'deleted/'+original_name) end
    if Dir.entries(File.dirname(self.path)).count <=2 then Dir.delete(File.dirname(self.path)) end
  end
end
