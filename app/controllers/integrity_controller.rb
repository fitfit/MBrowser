class IntegrityController < ApplicationController
  def index
    @thumb_no_time = Thumbnail.where(:time=>nil).count
  end

  def time_thumb
    Delayed::Job.enqueue ThumbTimeJob.new()
    render :nothing=>true
  end

  def purge_thumb
    Delayed::Job.enqueue ThumbPurgeJob.new()
    render :nothing=>true
  end

end
