class Thumbnail < ActiveRecord::Base
  belongs_to :tnable, :polymorphic => true
  has_many :system_files, :as => :storable, :dependent => :destroy

  def big_path
    return  '/' + self.system_files[0].path.split('/')[1..-1].join('/')
  end
end
