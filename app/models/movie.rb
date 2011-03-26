class Movie < ActiveRecord::Base
  include ActiveRecord::Transitions
  has_one :system_file, :class_name =>"SystemFile", :as => :storable, :dependent => :nullify
  has_many :thumbnails, :as => :tnable, :dependent => :destroy
  has_many :logs, :as => :loggable, :dependent => :destroy
  has_and_belongs_to_many :views
  acts_as_taggable
  before_save :update_tagged

  state_machine do
    state :added
    state :needs_thumbs
    state :thumbed
    state :needs_conversion
    state :converted

    event :init do
      transitions :to=>:needs_thumbs, :from => :added, :guard => :check_file_location_and_length
    end
    event :thumb do
      transitions :to => :thumbed, :from => :needs_thumbs, :guard =>  :try_to_make_thumbs
    end
  end

  def process
    self.delay.init!
  end

  def recalculate_time_of_thumbnails
    thumbnails.each do |t|
      t.time = (t.order*0.1*self.length).to_i;
      t.save!
    end
  end

  def check_file_location_and_length
    if File.exists?(self.system_file.path)
      self.compute_length
      unless self.length.nil?
        self.delay.thumb!
        return true;
      else
        Log.create(:title=>"Unable to get length of movie with ffmpeg",:controller=>'movie',:action=>"check_file_location_and_length",:loggable =>self)
        return false
      end
    else
      Log.create(:title=>"Movie without corresponding file in the library",:controller=>'movie',:action=>"check_file_location_and_length",:loggable =>self)
      return false
    end
  end

  def try_to_make_thumbs
    self.generate_thumbnail
  end

  def thumbs_exist?
    thumbs_ok = true
    unless self.thumbnails.count != 10
      self.thumbnails.each do |t|
        unless File.exists?(t.system_files[0].path)
          thumbs_ok = false
          Log.create(:title=>"Movie with thumbnail object but without files",:controller=>'movie',:action=>"try_to_make_thumbs",:loggable =>self)
        end
      end
    else
      thumb_ok = false
      Log.create(:title=>"Movie with less than then 10 thumbnails",:controller=>'movie',:action=>"try_to_make_thumbs",:loggable =>self)
    end
    return thumbs_ok
  end

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

  def compute_length
    f = self.system_file
    output = `"./bin/ffmpeg" -i #{f.path} 2>&1`
    times = output.scan(/Duration: (\d{2}):(\d{2}):(\d{2})/)[0]
    self.length = times[0].to_i*60*60 + times[1].to_i*60 + times[2].to_i
    save!
  end

  def generate_thumbnail
    unless self.thumbnails.empty?
      self.thumbnails.each{|t| t.destroy}
    end

    f = self.system_file
    n = f.original_name
    new_path = f.path.split('.')[0..-2].join('.')

    10.times do |i|
      i = i.to_i
      tt = self.length*0.1*i
      self.thumbnails << Thumbnail.create(:time=> tt, :order => i)
    end

    self.save!
  end

  def update_tagged
      self.tagged = !self.tag_list.empty?
    true
  end
end
