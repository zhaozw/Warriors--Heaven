class UserextsController < ApplicationController
  # GET /userexts
  # GET /userexts.xml
  def index
    @userexts = Userext.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @userexts }
    end
  end

  # GET /userexts/1
  # GET /userexts/1.xml
  def show
    @userext = Userext.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @userext }
    end
  end

  # GET /userexts/new
  # GET /userexts/new.xml
  def new
    @userext = Userext.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @userext }
    end
  end

  # GET /userexts/1/edit
  def edit
    @userext = Userext.find(params[:id])
  end

  # POST /userexts
  # POST /userexts.xml
  def create
    @userext = Userext.new(params[:userext])

    respond_to do |format|
      if @userext.save
        flash[:notice] = 'Userext was successfully created.'
        format.html { redirect_to(@userext) }
        format.xml  { render :xml => @userext, :status => :created, :location => @userext }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @userext.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /userexts/1
  # PUT /userexts/1.xml
  def update
    @userext = Userext.find(params[:id])

    respond_to do |format|
      if @userext.update_attributes(params[:userext])
        flash[:notice] = 'Userext was successfully updated.'
        format.html { redirect_to(@userext) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @userext.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /userexts/1
  # DELETE /userexts/1.xml
  def destroy
    @userext = Userext.find(params[:id])
    @userext.destroy

    respond_to do |format|
      format.html { redirect_to(userexts_url) }
      format.xml  { head :ok }
    end
  end
end
