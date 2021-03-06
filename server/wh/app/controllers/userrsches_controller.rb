class UserrschesController < ApplicationController
    
    def list
        list = {
            "东瀛系"=>["yidaoliu", "shendaotianxinliu",  ],
            "崆峒派"=>["konglingjian","qishangquan","liefengdaofa"],
            "五毒教"=>["chilianshenzhang", "xuedao"],
          #  "longxiang"=>[]
            }
        
        

        unread_list = {
            "崆峒派"=>[],
            "东瀛系"=>[],
            "五毒教"=>[]
        }
        read_list = []
        if (!user_data[:userrsch])
            rs = Userrsch.find_by_sql("select * from userrsches where uid=#{session[:uid]}")
            user_data[:userrsch] = rs
        end
        for r in user_data[:userrsch] # delete those already in research list
            skill = load_skill(r[:skname])
            skill.set_data(r)
            r[:dname] = skill.dname
            r[:desc] = skill.desc
            r[:mengpai] = skill.mengpai
            r[:image] = skill.image
            r[:dtype] = dtype(skill.type)
            p skill.inspect
            p "===> check  in meangpai #{skill.mengpai}:#{ list[skill.mengpai].inspect}"
            for l in list[skill.mengpai]
                p "==>#{l.inspect}"
                if l == r[:skname]
                    list[skill.mengpai].delete(l)
                    break
                end
            end
        end
        # p "==>userskills:#{user_data.userskills}"
        p user_data.skills.size
        for  r in user_data.skills # delete those already be user's skill
            p "==>r1=#{r.inspect}"
            if (!r || r.mengpai=="" || r.category == "basic")
                next
            end
            p "==>mengpai=#{r.mengpai}"
            for l in list[r.mengpai]
                if l == r[:skname]
                    list[r.mengpai].delete(l)        
                    break
                end
            end
        end
        keys = list.keys
        p "==>keys=#{keys.inspect}"
        for r in keys
            for rr in list[r]
                skill = load_skill(rr)
                rrr = {
                    :skname=>rr,
                    :dname=>skill.dname,
                    :desc=>skill.desc,
                    :mengpai=>skill.mengpai,
                    :image => skill.image,
                    :dtype=> dtype(skill.type)
                }
            
                unread_list[r].push(rrr)
            end
        end
        
        ret = {
            :unread=>unread_list,
            :read=>user_data[:userrsch]
        }
        return ret
    end
    
    def dtype(t)
        p "dtype #{t}"
        if t == 'daofa'
            return "刀法"
        elsif t == 'fencing' || t=='sword'
            return "剑法"
        elsif t == 'unarmed'
            return "拳法"
        elsif t == 'dodge'
            return "轻功"
        elsif t== 'heal'
            return '愈法'
        end
    end

    def index
  
        check_session
        ret = list
        render :text=>ret.to_json
    end
=begin    
    def test0
                check_session
        
        user_data[:a] = {:b=>"c"}
        p "===>a=#{user_data[:a][:b]}"
         render :text=>""     
    end
    def test
        check_session
        p "===>atest=#{user_data[:a][:b]}"
        t = user_data[:a]
         t[:b] = "d"
         render :text=>""        
    end
    
    def test2
        check_session
         p "===>atest=#{user_data[:a][:b]}"
         user_data[:a][:b] = "f"
         render :text=>"" 
    end
=end
    def research
        return if !check_session or !user_data
        user_data.ext[:lastact] = "research"
        use_pot = params[:pot] # use how much potential
        if (!use_pot)
            use_pot = 1
        end
        skill_name = params[:skname]
        
        check_session
           

        context ={
            :user => user_data,
            :msg => ""
        }
      
        skill = load_skill(skill_name)
        b = skill.checkResearchCondition(context)
        p "===>checkResearchCondition=#{b}"
        if (!b)
            error(context[:msg])
            return
        end
        
        ext = user_data.ext
        pot = ext[:pot]
        # if pot <= 0
        #      error ("You don't have enough potential")
        #      return
        #  end
        # calculate skillpoint
      #  gain = use_pot # maybe need change algorithm 
     

        
        point = use_pot*user_data.ext[:it].to_f*100/skill.needResearchPoint().to_f
        r = ActiveRecord::Base.connection.execute("insert into userrsches value (null, #{session[:uid]}, '#{session[:sid]}', '#{skill_name}', #{point}, NULL, NULL) on duplicate key update progress=progress+#{point}")
      #  p"===>raaaa=#{r}"
        
 
        rs = Userrsch.find_by_sql("select * from userrsches where uid=#{session[:uid]}")
  
        bFinish = false
        for r in rs
            if r[:skname] == skill_name
                if r[:progress] >= 100
                    bFinish = true
                    r.delete
                    rs.delete(r)
                    # begin
                    #                     s = Userskill.new({
                    #                         :uid    =>  session[:uid],
                    #                         :sid     => session[:sid],
                    #                         :skid    => 0,
                    #                         :skname  => skill_name,
                    #                         :skdname => "",
                    #                         :level   => 0,
                    #                         :tp      => 0,
                    #                         :enabled => 1
                    #                     })
                    #                     s.save!
                    # p "===>s=#{s}"
                    # rescue Exception=>e
                    #                        p e
                    #                    end
                    # if (user_data.userskills)
                    #     user_data.userskills.push(s)
                    # end
                    user_data.set_skill(skill_name, 0, 0)
                end
                break
            end
        end
        user_data[:userrsch] = rs
        
            
        # ext[:pot] -= 1
        # ext.save!
        user_data.check_save
      #  ret = {
       #     :msg => "你对书中的内容有所领悟",
      #      :progress=>point
       # }
       # p "=====>>>>"+ret.to_json
        #render :text=>ret.to_json
        ret = list
        dname = load_skill(skill_name).dname
        if bFinish
            ret[:msg] = "恭喜你参透了武功秘笈“#{dname}”!"
            ret[:add_skill] = user_data.query_skill(skill_name)
        else
            ret[:msg] = "你对书中的内容有所领悟"
        end
        render :text=>ret.to_json
    end
end
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
