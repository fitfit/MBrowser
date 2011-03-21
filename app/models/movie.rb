class Movie < ActiveRecord::Base
  has_many :system_files, :class_name =>"SystemFile", :as => :storable, :dependent => :nullify
  has_many :thumbnails, :as => :tnable, :dependent => :destroy
  acts_as_taggable

  def fancy_length
    unless self.length.nil?
    h = (self.length/3600).to_i
    m = ((self.length - h*3600)/60).to_i
    s = (self.length)%60
    {:hour => h.to_s,:min => m.to_s,:sec => s.to_s}
    else
      "Working..."
    end
  end

  def generate_thumbnail
    unless self.thumbnails.empty?
      self.thumbnails.each{|t| t.destroy}
    end
    f = self.system_files.first
    n = f.original_name
    new_path = f.path.split('.')[0..-2].join('.')
    output = `"./bin/ffmpeg" -i #{f.path} 2>&1`
    times = output.scan(/Duration: (\d{2}):(\d{2}):(\d{2})/)[0]
    
    self.length = times[0].to_i*60*60 + times[1].to_i*60 + times[2].to_i

    10.times do |i|
      i = i.to_i
      h = (self.length*0.1*i/3600).to_i
      m = ((self.length - h*3600)*0.1*i/60).to_i
      s = (self.length*0.1*i)%60
      `\"./bin/ffmpeg.exe\" 2>> ConvertLog.txt -ss #{h}:#{m}:#{s} -t 1 -s 400x300  -i #{f.path} -f image2 #{new_path + "_t" + i.to_s + ".jpg"}`
    self.thumbnails << Thumbnail.create(:order => i, :system_files => [SystemFile.create(:original_name => n.split('.')[0..-2].join('.') +"_thumb" +i.to_s , :name => n.split('.')[0..-2].join('.') + "_t" + i.to_s, :file_type => "jpg",:path => new_path + "_t" + i.to_s + ".jpg")])
    end

    self.save!
  end
end
