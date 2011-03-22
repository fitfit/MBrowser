class TaggingRoomController < ApplicationController
  def index
    @movie = nil
    Movie.all.each do |m|
      if m.tag_list.blank?
        @movie =m
        break
      end
    end
    @tags = Movie.tag_counts_on(:tags)
  end

  def tag
    @movie = Movie.find(params[:movie])
    @movie.tag_list = @movie.tag_list.join(', ') + "," + params[:tag]
    @movie.save!
  end

  def find
  end

end
