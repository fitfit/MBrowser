require 'UUID'
class DropboxController < ApplicationController
  ACCEPTED_EXT = [".flv",".mpg",".mpeg",".avi",".wmv"]
  def show
    dir = params[:dir] || './dropbox'
    @files = Dir.new(dir).entries.collect do |e|
      unless e == "." or e == ".."
        dir + "/" + e
      else
        if e == ".." and params[:dir]
          t =dir.split('/')
          t.slice!(-1)
          s= t.join('/')
        end
    end
    end
    @files.compact!
    puts @files
  end

  def add
    #f = File.open(params[:file])
    f = params[:file]
    process_file(f)

    redirect_to :action => "show"
  end

  def add_all
    dir = params[:dir] || './dropbox'
    Dir.new(dir).entries.each do |f|
      if not File.directory?(dir+ "/" + f) and ACCEPTED_EXT.include? File.extname(f)
        sf = process_file(dir+ "/" + f)
        Movie.create(:name => sf.original_name, :system_files => [sf]).delay.generate_thumbnail
      else unless File.directory?(dir+ "/" + f)
        reject_file(dir+ "/" +f)
           end
      end
      
    end
    redirect_to :action => "show", :notice => "Processed everything we could!"
  end

  private
  def process_file(file)
    n = UUID.new.generate
    ft = file.split('.').last
    path = "public/library/"+n+"." + ft
    FileUtils.mv(file,path)
    s = SystemFile.create(:original_name => File.basename(file), :name => n, :file_type => ft,:path => path)
  end

  def reject_file(file)
    FileUtils.mv(file,"rejected/"+File.basename(file))
  end


end
