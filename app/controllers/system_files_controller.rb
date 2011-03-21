class SystemFilesController < ApplicationController
  # GET /system_files
  # GET /system_files.xml
  def index
    @system_files = SystemFile.where(:storable_id => nil)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @system_files }
    end
  end

  # GET /system_files/1
  # GET /system_files/1.xml
  def show
    @system_file = SystemFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @system_file }
    end
  end

  # GET /system_files/new
  # GET /system_files/new.xml
  def new
    @system_file = SystemFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @system_file }
    end
  end

  # GET /system_files/1/edit
  def edit
    @system_file = SystemFile.find(params[:id])
  end

  # POST /system_files
  # POST /system_files.xml
  def create
    @system_file = SystemFile.new(params[:system_file])

    respond_to do |format|
      if @system_file.save
        format.html { redirect_to(@system_file, :notice => 'System file was successfully created.') }
        format.xml  { render :xml => @system_file, :status => :created, :location => @system_file }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @system_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /system_files/1
  # PUT /system_files/1.xml
  def update
    @system_file = SystemFile.find(params[:id])

    respond_to do |format|
      if @system_file.update_attributes(params[:system_file])
        format.html { redirect_to(@system_file, :notice => 'System file was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @system_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /system_files/1
  # DELETE /system_files/1.xml
  def destroy
    @system_file = SystemFile.find(params[:id])
    @system_file.destroy

    respond_to do |format|
      format.html { redirect_to(system_files_url) }
      format.xml  { head :ok }
    end
  end
end
