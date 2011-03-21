class TagsController < ApplicationController
  def index
    @tags = Movie.tag_counts_on(:tags)
  end

  def show
    @movies = Movie.tagged_with(params[:id]).paginate :page => params[:page], :per_page => 24
    
  end

end
