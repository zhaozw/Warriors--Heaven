class UserquestsController < ApplicationController
  # GET /userquests
  # GET /userquests.xml
  def index
    @userquests = Userquest.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @userquests }
    end
  end

  # GET /userquests/1
  # GET /userquests/1.xml
  def show
    @userquest = Userquest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @userquest }
    end
  end

  # GET /userquests/new
  # GET /userquests/new.xml
  def new
    @userquest = Userquest.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @userquest }
    end
  end

  # GET /userquests/1/edit
  def edit
    @userquest = Userquest.find(params[:id])
  end

  # POST /userquests
  # POST /userquests.xml
  def create
    @userquest = Userquest.new(params[:userquest])

    respond_to do |format|
      if @userquest.save
        flash[:notice] = 'Userquest was successfully created.'
        format.html { redirect_to(@userquest) }
        format.xml  { render :xml => @userquest, :status => :created, :location => @userquest }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @userquest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /userquests/1
  # PUT /userquests/1.xml
  def update
    @userquest = Userquest.find(params[:id])

    respond_to do |format|
      if @userquest.update_attributes(params[:userquest])
        flash[:notice] = 'Userquest was successfully updated.'
        format.html { redirect_to(@userquest) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @userquest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /userquests/1
  # DELETE /userquests/1.xml
  def destroy
    @userquest = Userquest.find(params[:id])
    @userquest.destroy

    respond_to do |format|
      format.html { redirect_to(userquests_url) }
      format.xml  { head :ok }
    end
  end
end
