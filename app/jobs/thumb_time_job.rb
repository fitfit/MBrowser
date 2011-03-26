class ThumbTimeJob
  def perform
    Movie.all.each do |m|
      m.delay.recalculate_time_of_thumbnails
    end
  end
end