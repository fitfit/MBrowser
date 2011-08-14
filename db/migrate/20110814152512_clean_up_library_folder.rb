class CleanUpLibraryFolder < ActiveRecord::Migration
  def self.up
    Movie.includes(:thumbnails).find_each do |m|
      filepath = m.system_file.path
      if File.exist?(filepath)
        date = File.stat(filepath).mtime
        dirpath = "public/library/#{date.year}-#{date.month}/#{m.system_file.name}/"
        newfilepath = dirpath + m.system_file.name + "." + m.system_file.file_type
        FileUtils.mkdir_p dirpath
        FileUtils.mv(filepath,newfilepath)
        m.system_file.path = newfilepath
        m.system_file.save
        m.thumbnails.each do |t|
          t.system_files.each do |f|
            newffilepath = dirpath + File.basename(f.path)
            if File.exist?(f.path)
              FileUtils.mv(f.path,newffilepath)
            end
            f.path = newffilepath
            f.save
          end
        end
      end


    end
  end

  def self.down
  end
end
