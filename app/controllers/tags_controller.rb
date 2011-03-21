class TagsController < ApplicationController
  def index
    @tags = Movie.tag_counts_on(:tags)
  end

  def show
  end

end
