require "objects/equipments/equipment.rb"
class TradablesController < ApplicationController
    
    
    def index
        sid = cookies[:_wh_session]    
      # for test
      if (params[:sid])
          sid = params[:sid]
      end
      type = params[:type]
        
        ts = Tradable.find_by_sql("select * from tradables where objtype=#{type}")
        if !ts || ts.size == 0
            render :text=>"{}"
            return
        end
        
        for t in ts
            _t = Equipment.load_equipment(t[:name], t)
            t[:dname] = _t.dname
            t[:desc] = _t.desc
            t[:weight] = _t.desc
            t[:pos] = _t.wearOn
            t[:file] = _t.file
        end
        
        render :text=>ts.to_json
        
    end
=begin
  # GET /tradables
  # GET /tradables.xml
  def index
    @tradables = Tradable.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tradables }
    end
  end

  # GET /tradables/1
  # GET /tradables/1.xml
  def show
    @tradable = Tradable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tradable }
    end
  end

  # GET /tradables/new
  # GET /tradables/new.xml
  def new
    @tradable = Tradable.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tradable }
    end
  end

  # GET /tradables/1/edit
  def edit
    @tradable = Tradable.find(params[:id])
  end

  # POST /tradables
  # POST /tradables.xml
  def create
    @tradable = Tradable.new(params[:tradable])

    respond_to do |format|
      if @tradable.save
        flash[:notice] = 'Tradable was successfully created.'
        format.html { redirect_to(@tradable) }
        format.xml  { render :xml => @tradable, :status => :created, :location => @tradable }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tradable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tradables/1
  # PUT /tradables/1.xml
  def update
    @tradable = Tradable.find(params[:id])

    respond_to do |format|
      if @tradable.update_attributes(params[:tradable])
        flash[:notice] = 'Tradable was successfully updated.'
        format.html { redirect_to(@tradable) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tradable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tradables/1
  # DELETE /tradables/1.xml
  def destroy
    @tradable = Tradable.find(params[:id])
    @tradable.destroy

    respond_to do |format|
      format.html { redirect_to(tradables_url) }
      format.xml  { head :ok }
    end
  end
=end
end
