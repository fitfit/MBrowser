class ThumbPurgeJob
  def perform
    Thumbnail.all.each do |t|
      if t.tnable.nil?
        t.destroy
      end
    end
  end
end