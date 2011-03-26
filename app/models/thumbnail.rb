class Thumbnail < ActiveRecord::Base
  belongs_to :tnable, :polymorphic => true
  has_many :system_files, :as => :storable, :dependent => :destroy
  has_many :logs, :as=>:loggable, :dependent => :destroy
  after_create :make_thumbs

  def big_path
    unless self.system_files.empty?
      return  '/' + self.system_files[0].path.split('/')[1..-1].join('/')
    else
      return "#"
    end
    
  end

  def generate(offset=0)
    h = (self.time/3600).to_i
    m = ((self.time - h*3600)/60).to_i
    s = (self.time)%60
    new_path = tnable.system_file.path.split('.')[0..-2].join('.')
    n= tnable.name
    system_files << SystemFile.create(:original_name => n.split('.')[0..-2].join('.') +"_thumb" + order.to_s ,:name => n.split('.')[0..-2].join('.') + "_t" + order.to_s, :file_type => "jpg",:path => new_path + "_t" + order.to_s + ".jpg")

    `\"./bin/ffmpeg.exe\" 2>&1 -ss #{h}:#{m}:#{s} -s 400x300  -i #{tnable.system_file.path} -f image2 #{self.system_files[0].path}`

    unless self.exists?
      Log.create(:title=>"Tried to create thumbnail but file still does not exists",:controller=>'thumbnail',:action=>"generate",:loggable =>self)
    end
  end

  def exists?
    File.exists?(system_files[0].path)
  end

  def make_thumbs
    self.delay.generate(0)
  end
end
