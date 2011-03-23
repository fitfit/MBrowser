class TaggingRoomController < ApplicationController
  def index
    @movie = nil
    ms = Movie.all
    r = rand(ms.count)
    ms[r+1..-1].concat(ms[0..r]).each do |m|
      if m.tag_list.blank?
        @movie =m
        break
      end
    end
    if @movie.nil? then @movie = ms[r] end
    @tags = Movie.tag_counts_on(:tags)
    @tagged_count = Movie.where(:tagged => true).count
    @movies_count = Movie.all.count
  end

  def tag
    @movie = Movie.find(params[:movie])
    @movie.tag_list.add(params[:tag])
    @movie.save!
  end

  def untag
    @movie = Movie.find(params[:movie])
    @movie.tag_list.remove(params[:tag])
    @movie.save!
    render :nothing => true
  end

  def find
  end

end
