#require "objects/equipments/equipment.rb"
require 'utility.rb'
class UsereqsController < ApplicationController
    def index
        sid = cookies[:_wh_session]    
      # for test
      if (params[:sid])
          sid = params[:sid]
      end
        
        eqs = Usereq.find_by_sql(" select * from usereqs, equipment where usereqs.eqid=equipment.id and sid='#{sid}'")
        if !eqs || eqs.size == 0
            render :text=>"{}"
            return
        end
        
        for eq in eqs
            _eq = nil
            p "eqtype=#{eq[:eqtype]}"
            if eq[:eqtype].to_i == 1
                _eq = Equipment.load_equipment(eq[:eqname], eq)
            else
                p "jjjjjjjjj"
                _eq = load_obj(eq[:eqname], eq)
            end
            eq[:dname] = _eq.dname
            eq[:desc] = _eq.desc
            eq[:weight] = _eq.desc
            eq[:pos] = _eq.wearOn
            eq[:image] = _eq.image
        end
        
        render :text=>eqs.to_json
        
    end
    
    def save
        #p request
      p "===>"+request.body.read
        p "--->"+request.raw_post
        p request.content_type
     #   p params[:data]
      #  p request_origin
        success("OK")
    end
=begin
  # GET /usereqs
  # GET /usereqs.xml
  def index
    @usereqs = Usereq.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @usereqs }
    end
  end

  # GET /usereqs/1
  # GET /usereqs/1.xml
  def show
    @usereq = Usereq.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @usereq }
    end
  end

  # GET /usereqs/new
  # GET /usereqs/new.xml
  def new
    @usereq = Usereq.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @usereq }
    end
  end

  # GET /usereqs/1/edit
  def edit
    @usereq = Usereq.find(params[:id])
  end

  # POST /usereqs
  # POST /usereqs.xml
  def create
    @usereq = Usereq.new(params[:usereq])

    respond_to do |format|
      if @usereq.save
        flash[:notice] = 'Usereq was successfully created.'
        format.html { redirect_to(@usereq) }
        format.xml  { render :xml => @usereq, :status => :created, :location => @usereq }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @usereq.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /usereqs/1
  # PUT /usereqs/1.xml
  def update
    @usereq = Usereq.find(params[:id])

    respond_to do |format|
      if @usereq.update_attributes(params[:usereq])
        flash[:notice] = 'Usereq was successfully updated.'
        format.html { redirect_to(@usereq) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @usereq.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /usereqs/1
  # DELETE /usereqs/1.xml
  def destroy
    @usereq = Usereq.find(params[:id])
    @usereq.destroy

    respond_to do |format|
      format.html { redirect_to(usereqs_url) }
      format.xml  { head :ok }
    end
  end

=end
end
