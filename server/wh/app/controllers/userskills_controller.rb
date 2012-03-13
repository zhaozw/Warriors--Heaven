class UserskillsController < ApplicationController
  # GET /userskills
  # GET /userskills.xml
  def index
    @userskills = Userskill.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @userskills }
    end
  end

  # GET /userskills/1
  # GET /userskills/1.xml
  def show
    @userskill = Userskill.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @userskill }
    end
  end

  # GET /userskills/new
  # GET /userskills/new.xml
  def new
    @userskill = Userskill.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @userskill }
    end
  end

  # GET /userskills/1/edit
  def edit
    @userskill = Userskill.find(params[:id])
  end

  # POST /userskills
  # POST /userskills.xml
  def create
    @userskill = Userskill.new(params[:userskill])

    respond_to do |format|
      if @userskill.save
        flash[:notice] = 'Userskill was successfully created.'
        format.html { redirect_to(@userskill) }
        format.xml  { render :xml => @userskill, :status => :created, :location => @userskill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @userskill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /userskills/1
  # PUT /userskills/1.xml
  def update
    @userskill = Userskill.find(params[:id])

    respond_to do |format|
      if @userskill.update_attributes(params[:userskill])
        flash[:notice] = 'Userskill was successfully updated.'
        format.html { redirect_to(@userskill) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @userskill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /userskills/1
  # DELETE /userskills/1.xml
  def destroy
    @userskill = Userskill.find(params[:id])
    @userskill.destroy

    respond_to do |format|
      format.html { redirect_to(userskills_url) }
      format.xml  { head :ok }
    end
  end
end
