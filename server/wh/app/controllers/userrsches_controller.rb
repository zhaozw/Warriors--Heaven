class UserrschesController < ApplicationController
=begin
  # GET /userrsches
  # GET /userrsches.xml
  def index
    @userrsches = Userrsch.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @userrsches }
    end
  end

  # GET /userrsches/1
  # GET /userrsches/1.xml
  def show
    @userrsch = Userrsch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @userrsch }
    end
  end

  # GET /userrsches/new
  # GET /userrsches/new.xml
  def new
    @userrsch = Userrsch.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @userrsch }
    end
  end

  # GET /userrsches/1/edit
  def edit
    @userrsch = Userrsch.find(params[:id])
  end

  # POST /userrsches
  # POST /userrsches.xml
  def create
    @userrsch = Userrsch.new(params[:userrsch])

    respond_to do |format|
      if @userrsch.save
        flash[:notice] = 'Userrsch was successfully created.'
        format.html { redirect_to(@userrsch) }
        format.xml  { render :xml => @userrsch, :status => :created, :location => @userrsch }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @userrsch.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /userrsches/1
  # PUT /userrsches/1.xml
  def update
    @userrsch = Userrsch.find(params[:id])

    respond_to do |format|
      if @userrsch.update_attributes(params[:userrsch])
        flash[:notice] = 'Userrsch was successfully updated.'
        format.html { redirect_to(@userrsch) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @userrsch.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /userrsches/1
  # DELETE /userrsches/1.xml
  def destroy
    @userrsch = Userrsch.find(params[:id])
    @userrsch.destroy

    respond_to do |format|
      format.html { redirect_to(userrsches_url) }
      format.xml  { head :ok }
    end
  end
=end

    def index
        list = [
            "taidaoliu",
            "kaishanzhang"
            ]
        
        check_session
        unread_list = []
        rs = Userrsches.find_by_sql("select * from userrsches where uid=#{session[:uid]}")
        for r in rs
            for l in list
                if l == r[:skname]
                    list.delete(l)
                    break
                end
            end
        end
        
        ret = {
            :unread=>list
            
        }
        
    end
end
