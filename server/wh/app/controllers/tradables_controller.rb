#require "objects/equipments/equipment.rb"
require "rubyutility.rb"
require 'md5'   
class TradablesController < ApplicationController
    
    
    def index
        sid = cookies[:_wh_session]    
      # for test
      if (params[:sid])
          sid = params[:sid]
      end
      type = params[:type]
        # if (!type)
        #       error("You didn't specify item type")
        #       return 
        #   end
        if type
            ts = Tradable.find_by_sql("select * from tradables where obtype=#{type}")
        else
            ts = Tradable.find_by_sql("select * from tradables")
        end
        if !ts || ts.size == 0
            render :text=>"{}"
            return
        end
        
        ret = []
        for t in ts
            _t = Equipment.load_equipment(t[:name], t)
            # t[:dname] = _t.dname
            # t[:desc] = _t.desc
            # t[:weight] = _t.desc
            # if t[:obtype] == 1
            #     t[:pos] = _t.wearOn
            # end
            # t[:intro] = _t.intro
            # t[:image] = _t.image
            # t[:rank] = _t.rank
            # t[:price] = _t.price
            ret.push(_t)
        end
        
        render :text=>ret.to_json
    end
    
    def buy
        return if !check_session or !user_data
        player.recover
        uid = session[:uid]
        item_id = params[:id]
        item = Tradable.find(item_id)
        obj = load_obj(item[:name], item)
        
        if (item[:number] < 1)
            error("There is not enough number of item in stock. Please buy later.")
            return
        end
        max_eq = user_data.ext.get_prop("max_eq").to_i
        eqslot = user_data.ext.get_prop("eqslot")
            
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
        
        if obj.instantiatable
            # check user has enough vacancy
            p "==> item: #{item.inspect}"
            if item[:obtype] == 1 or item[:obtype] == 3
                # find available slot
               # r = ActiveRecord::Base.connection.execute("select count(*) from usereqs, equipment where usereqs.uid=#{uid} and  usereqs.eqid=equipment.id and equipment.eqtype=1")
               # count = r.fetch_row[0].to_i
                #if (count+1 > session[:userdata][:userext][:max_eq].to_i)
                #    error("There is not availabe slot for new equipment. You can buy more slot.")
                #    return
               # end

               if (eqslot)
                   if eqslot.class==String
                       eqslot = JSON.parse(eqslot)
                   end
                       p "===> eqslot: #{eqslot.inspect}, #{eqslot['0']}"
                   for i in 0..max_eq-1
                       p "===>slot[#{i}] #{eqslots[i.to_s]}"
                       if !eqslots[i.to_s]
                           found_available = i
                           break
                        end
                   end
                   if found_available < 0
                       # error("There is not availabe slot for new equipment. You can buy more slot.")
                       error("你的装备栏已经满了.你可以购买更多装备栏。")
                       return
                   end
               else
                     found_available =0
               end
            else item[:obtype] == 2 or item[:obtype] == 4
                r = ActiveRecord::Base.connection.execute("select count(*) from equipment where owner=#{uid} and (eqtype=2 or eqtype=4)")
                count = r.fetch_row[0].to_i
                p "item count #{count}"
            #    p session[:userdata]
                if (count+1 > user_data.ext.get_prop("max_item").to_i)
                    # error("There is not availabe slots for new item. You can buy more slot.")
                    error("你的物品栏已经满了.你可以购买更多物品栏。")
                    return
                end
            end
        end # if obj.instantiatable
  
        # check if user has enough gold
        gold = user_data.ext[:gold]
     
        # price = item[:price]
        price = obj.price
        if (gold -price <0)
            error("Sorry, you don't have enough gold.")
            return
        end
        
        # ===============================================
        # OK, trade pass check, create object for player
        # ===============================================
        
        if obj.instantiatable
        
            # create instance
            e = Equipment.new({
                :eqname  => item[:name],
                :eqtype  => item[:obtype], 
                :prop    => obj.vars.to_json,
                :owner     => user_data[:id]
            })
            e.save!
 
            obj.set_data(e)
            eqslots[found_available.to_s] = e[:id]
            #user_data[:userext][:eqslot] = eqslots.to_json
            user_data.ext.set_prop("eqslot", eqslots.to_json)
            user_data.ext[:gold] -= price
            user_data.get_obj(obj)
            
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

        # ueq = Usereq.new({                        
        #         :uid        => uid                ,
        #         :sid        => session[:sid]      ,
        #         :eqid       => e[:id]             ,
        #         :eqname     => item[:name]        ,
        #         :eqslotnum  => found_available.to_s             ,
        #         :wearon     => nil
        #        
        #     })
        # ueq.save!
        end
        item[:soldnum] += 1
        item[:number] -= 1
        item.save!
        
        
        # =================
        # special effect of item when user buy it
        # =================
        if (obj.obj_type == "special" and obj.useonbuy)
            c = {:player=>player}
            obj.use(c)
        end
        
       # eq = Equipment.load_equipment(item[:name], item)
       ret = {
           # :gold=>user_data.ext[:gold],
           :msg =>"您购买了 #{item[:dname]}  !\n Gold -#{price}",
           :updated=>user_data.ext
       }
      # success("You bought #{item[:dname]} successfully !\n Gold -#{price}")
      render :text=>ret.to_json
      user_data.check_save
    end
    
    def listProduct
        list_normal_price =[
            {    :id=>"gold",
                :name=>"1000Gold",
                :price=>"CN¥6"
            },
            {    :id=>"5000gold",
                :name=>"5000Gold",
                  :price=>"CN¥18"
            },
                        {    :id=>"8000gold",
                :name=>"8000Gold",
                  :price=>"CN¥25"
            },
                        {    :id=>"10000gold",
                :name=>"10000Gold",
                  :price=>"CN¥30"
            },
                        {    :id=>"20000gold",
                :name=>"20000Gold",
                  :price=>"CN¥40"
            },
                        {
                             :id=>"50000gold",
                :name=>"50000Gold",
                  :price=>"CN¥98"
            }
            
            ]    

            list_onsale= [
              {
                  :id=>"2000gold",
                :name=>"2000Gold",
                :price=>"CN¥12",
                :onsale=>"CN¥6",
                :discount=>"-50%"
            },
            {
                     :id=>"5000gold",
                :name=>"5000Gold",
                :price=>"CN¥18",
                :onsale=>"CN¥12",
                :discount=>"-33%"
            },
                        {
                                 :id=>"8000gold",
                :name=>"8000Gold",
                  :price=>"CN¥25"
            },
                        {
                                 :id=>"10000gold",
                :name=>"10000Gold",
                  :price=>"CN¥30"
            },
                        {
                                 :id=>"20000gold",
                :name=>"20000Gold",
                  :price=>"CN¥40"
            },
                        {
                                 :id=>"50000gold",
                :name=>"50000Gold",
                  :price=>"CN¥98"
            }
            ]
            @iap_list = list_onsale
            # render :template=>"tradables/listProduct2"
            render :template=>"tradables/listProduct2.html.erb"
    end
    def getT
        if params[:tid] != nil && params[:tid].size>0
            k = generate_password(32)
            r = Iapkey.new({
                :uid=>user_data[:id],
                :sid=>user_data[:sid],
                :key=>k,
                :tid=>params[:tid]
            })
            r.save!
        end
        success("done", {:k=>k})
    end
    def encroptT(c)
        p "===>111"
        #d61eabe4211dc8abfa2097c4e8008b17
        #fb878cea0081ca975738417cfc17a71a
        sid = user_data[:sid]
        p sid
       k = sid.to(15)+user_data[:id].to_s+sid[16..sid.size-1] 
       p k
       k = k.to(16)+c+k[17..k.size-1] 
       p k
       a =  MD5.hexdigest(k)   
       p a.to_s
       return a
        
    end
    def purchase
        #c = FnnatNprm8MMODTehd44j54YnTBYkTJ2
        #sid =ce17b7dbc51f7fc56bb6482c9a7dd9a1
        return if !check_session or !user_data
        # rs =  Iapkey.find_by_sql("select * from iapkeys where tid='#{params[:tid]}'")
        # if rs && rs.size > 0
        #     r = rs[0]
        #     if r
        #         c = params[:c]
        #         a =  encroptT(r[:key])
        #         if a == c
        #       
        #         success("done", {:sid=>user_data[:sid], :a=>a})
        #         return
        #           end
        #     end
        # end
        if encroptT(params[:tid]) == params[:c]
             success("done", {:tid =>params[:tid]})
         else
             error("找不到该记录！")
         end
  
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
