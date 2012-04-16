#require "objects/equipments/equipment.rb"
class TradablesController < ApplicationController
    
    
    def index
        sid = cookies[:_wh_session]    
      # for test
      if (params[:sid])
          sid = params[:sid]
      end
      type = params[:type]
        if (!type)
            error("You didn't specify item type")
            return 
        end
        ts = Tradable.find_by_sql("select * from tradables where obtype=#{type}")
        if !ts || ts.size == 0
            render :text=>"{}"
            return
        end
        
        for t in ts
            _t = Equipment.load_equipment(t[:name], t)
            t[:dname] = _t.dname
            t[:desc] = _t.desc
            t[:weight] = _t.desc
            if t[:obtype] == 1
                t[:pos] = _t.wearOn
            end
            t[:intro] = _t.intro
            t[:image] = _t.image
            t[:rank] = _t.rank
        end
        
        render :text=>ts.to_json
    end
    
    def buy
        check_session
        if !session[:userdata] 
            error("session 不存在， 请重新启动游戏")
            return
        end
        uid = session[:uid]
        item_id = params[:id]
        item = Tradable.find(item_id)
        
        if (item[:number] < 1)
            error("There is not enough number of item in stock. Please buy later.")
            return
        end
        max_eq = user_data[:userext][:max_eq].to_i
        eqslot = user_data[:userext][:eqslot]
                     
        found_available = -1
        p eqslot
        if eqslot
            if (eqslot.class == String)
                eqslots = JSON.parse(eqslot)
            else
                eqslots = eqslot
            end
        else
            eqslots ={}
        end
        # check user has enough vacancy
        if item[:obtype] == 1 or item[:obtype] == 3
            # find available slot
           # r = ActiveRecord::Base.connection.execute("select count(*) from usereqs, equipment where usereqs.uid=#{uid} and  usereqs.eqid=equipment.id and equipment.eqtype=1")
           # count = r.fetch_row[0].to_i
            #if (count+1 > session[:userdata][:userext][:max_eq].to_i)
            #    error("There is not availabe slot for new equipment. You can buy more slot.")
            #    return
           # end
   
           if (eqslot)

               for i in 0..max_eq-1
                   p "slot[#{i}] #{eqslots[i.to_s]}"
                   if !eqslots[i.to_s]
                       found_available = i
                       break
                    end
               end
               if found_available < 0
                   error("There is not availabe slot for new equipment. You can buy more slot.")
                   return
               end
           else
                 found_available =0
           end
        else item[:obtype] == 2
            r = ActiveRecord::Base.connection.execute("select count(*) from usereqs, equipment where usereqs.uid=#{uid} and usereqs.eqid=equipment.id and equipment.eqtype=2")
            count = r.fetch_row[0].to_i
            p session[:userdata]
            if (count+1 > session[:userdata][:userext][:max_item])
                error("There is not availabe slots for new item. You can buy more slot.")
                return
            end
        end
        
  
        # check if user has enough gold
        gold = session[:userdata][:userext][:gold]
        price = item[:price]
        if (gold -price <0)
            error("Sorry, you don't have enough gold.")
            return
        end
        # create instance
        e = Equipment.new({
            :eqname  => item[:name],
            :eqtype  => item[:obtype], 
            :prop    => "{}"
        })
        e.save!
 
 
        eqslots[found_available.to_s] = e[:id]
        #user_data[:userext][:eqslot] = eqslots.to_json
        user_data[:userext].set_prop("eqslot", eqslots.to_json)
        user_data[:userext].save!
=begin     
        # get available slot number
        r =  ActiveRecord::Base.connection.execute("select eqslotnum from usereqs where uid=#{uid}")
         p r.inspect
        slots = []
        for _r in r 
            if _r[0].to_i >=0
                slots[_r[0].to_i] = 1
            end
        end
        a_slot= -1
        for s in slots
            a_slot += 1
            if (slots[a_slot] == nil)
                break
            end
        end
=end

        ueq = Usereq.new({                        
                :uid        => uid                ,
                :sid        => session[:sid]      ,
                :eqid       => e[:id]             ,
                :eqname     => item[:name]        ,
                :eqslotnum  => found_available.to_s             ,
                :wearon     => nil
               
            })
        ueq.save!
        item[:soldnum] -= 1
        item.save!
        
       # eq = Equipment.load_equipment(item[:name], item)
      success("You bought #{item[:dname]} successfully !")

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
