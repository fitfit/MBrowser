class MoviesController < ApplicationController
  # GET /movies
  # GET /movies.xml
  def index
#    if params[:page]
#      session[:page] = params[:page]
#    end
#    @page = session[:page]
#    @movies = Movie.paginate :page => session[:page], :per_page => 24
    if params[:view].nil? then session[:view] = View.find_by_name('Newest').id end
    m = View.find(session[:view]).get_movies
    @nb_row = (m.count/6).to_i + 1
    @movies = m.paginate :page => params[:page], :per_page => 24

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movies }
    end
  end

  def row
#    m =View.find(session[:view]).get_movies
#    @nb = m.count
    @nb = 6
    @movies = Movie.paginate :page => params[:page], :per_page => 6
    respond_to do |format|
      format.html {render 'row',:layout => false}
      format.xml  { render :xml => @movies }
    end
  end

  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = Movie.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie }
      format.js {
      }
    end
  end

  def thumbs
    @movie = Movie.includes(:thumbnails).find(params[:id])
    render :partial => 'thumbnails'
  end

  def thumb
    @movie = Movie.find(params[:id])
    render :partial => 'movie', :locals =>{:movie => @movie}, :layout => false
  end

  # GET /movies/new
  # GET /movies/new.xml
  def new
    @movie = Movie.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id])
  end

  # POST /movies
  # POST /movies.xml
  def create
    @movie = Movie.new(params[:movie])
    @movie.name = @movie.system_files.first.original_name
    @movie.delay.generate_thumbnail
    respond_to do |format|
      if @movie.save
        format.html { redirect_to(@movie, :notice => 'Movie was successfully created.') }
        format.xml  { render :xml => @movie, :status => :created, :location => @movie }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /movies/1
  # PUT /movies/1.xml
  def update
    @movie = Movie.find(params[:id])

    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        format.html { redirect_to(edit_movie_path(@movie), :notice => 'Movie was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.xml
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to(movies_url) }
      format.xml  { head :ok }
    end
  end
end
