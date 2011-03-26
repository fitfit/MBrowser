class ThumbPurgeJob
  def perform
    Thumbnail.all.each do |t|
      t.destroy
    end
  end
end