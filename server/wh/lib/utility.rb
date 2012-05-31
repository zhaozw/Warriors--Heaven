def create_npc(path)
    o = loadGameObject(path)
    return o
end

def create_obj(path)
    r = loadGameObject(path)
    eqtype=2
    case r.obj_type
        when "special":eqtype=4
        when "fixture":eqtype=2
        when "equipment":eqtype=1
        when "premium":eqtype=4
    end
    prop={
        :hp=>r.hp
    }
        o = Equipment.new({
                    :eqname=>path,
                    :eqtype=>eqtype,
                    :prop=>prop.to_json,
                    :owner =>0
                })
        # o.save!
      
    
    r.set_data(o)
    return r
end
def create_equipment(path)
    # o = Equipment.new({
    #                 :eqname=>path,
    #                 :eqtype=>1,
    #                 :prop=>"{}",
    #                 :owner =>0
    #             })
    #     # o.save!
    #   
    # r = loadGameObject(path)
    # r.set_data(o)
    # return r
    create_obj(path)
end

def create_fixure(path)
        # o = Equipment.new({
        #             :eqname=>path,
        #             :eqtype=>2,
        #             :prop=>"{}",
        #             :owner =>0
        #         })
        # # o.save!
        #       
        # r = loadGameObject(path)
        # r.set_data(o)
        # return r
        create_obj(path)
    end
    def load_obj(path, o=nil)
        r = loadGameObject(path)
        r.set_data(o) if o
        return r
    end
=begin
def translate_msg msg, context
    if (!msg)
        return ""
    end
#    userext = context[:user].ext
    target = context[:target]
    p "=>msg = #{msg}"
    p "=>target = #{target.inspect}"
    return msg.gsub(/\$N/m, "你").gsub("/\$n/m", target.name)
end
=end
    def loadGameObject(path)
        p "require '"+ path+".rb'"
        eval "require '"+ path+".rb'"      
        b = path.split('/')
        name = b[b.size-1]
        target_class = name.at(0).upcase+name.from(1)
        targetObj=eval target_class+'.new()'
        
    #    targetObj.set(o) if o
        return targetObj
        
    end
    
    def queryGameObject(targetObj, method, params)
         m = targetObj.method(method)
         return m.call(params)
    end
    
   
   # load skill object, without user data
    def load_skill (skillname, data = nil)
             # eval skill class
                eval "require 'skills/"+ skillname+".rb'"
               
                target_class = skillname.at(0).upcase+skillname.from(1)
                targetObj=eval target_class+'.new()'
                targetObj.set_data(data) if data
                return targetObj
                
    end
=begin 
    def query_skill(skillname, method, skill, context)
         targetObj = load_skill(skillname)
         m = targetObj.method("set")
         m.call(skill)
         
         m = targetObj.method(method);
        if (method == "for" or method=="type")
             return m.call()
         else
             return m.call(context)
         end
    end
=end   
    def query_obj(objname, method, obj, context)
        eval "require 'objects/"+ objname+".rb'"         
        target_class = objname.at(0).upcase+objname.from(1)
        targetObj=eval target_class+'.new()'
        m = targetObj.method("set");
        m.call(obj)
        
        m = targetObj.method(method);
        if context
            return m.call(context)
        else
            return m.call
        end
         
    end
    
    def add_exp(add_exp)
        
    end

    # def move_obj(v,p)
    #     r = v.data
    #     if !r
    #         
    #     end
    # end
    
    def getfiles(path)  
        re = []  
        allre = []  
        Dir.foreach(path) do |f|  
            allre << f  
        end  
        allre.each do |f|  
            fullfilename = path + "/" + f  
            if f == "." or f == ".."   
            elsif File.directory?(fullfilename)  
                resub = []  
                resub = getfiles(fullfilename)  
          
                if resub.length > 0  
                    ref = {}  
                    ref[f] = resub  
                    re << ref  
                end  
            elsif File.exist?(fullfilename) and (f =~ /\.rb$/) # only rb file  
                re << f  
            end  
        end  
        return re  
    end
    
    def cacl_fullskill(level)
        exp = calc_total_exp(level)
        
        return (exp*10)**(1/3.0)#+1
    end
    def calc_total_exp(level)
        p "==>level=#{level}"
        return 0 if level==0
        r  = 0
        for i in 1..level
            r += i*i*i
        end
        p "=>exp of level #{level} is #{r}"
        return r
    end
    
    # prop can be json obj or json string
    # return new json string
    def set_prop(prop, n,v)
        js = prop
        if js.class == String
            js = JSON.parse(prop)
        end

      js[n] = v
     return  js.to_json

  end
  

    # prop can be json obj or json string
 
    def get_prop(prop, k)
        js = prop
        if js.class == String
            js = JSON.parse(prop)
        end
        if js
            return js[k]
        else
            return nil
        end
    end
  def util_get_prop(prop, n)
      get_prop(prop, n)
  end
  def util_set_prop(prop,n,v)
      set_prop(prop,n,v)
  end
  
    def calc_zhanli(livingObj)
        return livingObj.tmp[:level]
    end
    
    # non-randam rand
    def rand1(max, desc)        
        ret = (rand(max*2)+rand(max*2))/2
        ret = max if ret > max
        if desc 
            return ret
        else
            return max - ret
        end
    end
    # ==========================
    #  For fight related
    # ==========================
    
    def move_obj(obj, p1, p2)
        p1.remove_obj(obj)
        p2.get_obj(obj)
    end
    
    def drop_all(p1, p2)
        objs = p1.query_all_obj
        objs.each{|o|
            move_obj(o, p1, p2)
        }
        return objs
    end
    # player1 drop equipment randomly to player2
    # q is chance to drop compare to rand(10), q is bigger, chance is more.
    def rand_drop(p1, p2, q=5)
        if rand(10)<q
            return
        end
        
        # drop equipment
        drop = []
        objs = p1.query_all_wearings.values
        p "==>objs:#{objs.inspect}"
        r = rand(objs.size*2)
        r=0
        p "===>r=#{r} obj size #{objs.size}"
      
        if r < objs.size && objs[r] != nil
            p "==>move obj #{objs[r].inspect}"
            move_obj(objs[r], p1, p2)
            drop.push(objs[r])
        end
        
        # drop object
        objs = p1.query_carrying
         r = rand(objs.size*2)
         if r < objs.size && objs.obj_type !="equipment" and objs.obj_type != "special"
             move_obj(objs[r], p1, p2)
             drop.push(objs[r])
         end
        
         
         return drop
    end
    
    def rand_drop_gold(p1, p2, q=5)
        if rand(10)<q
            return 0
        end
     
         # drop gold
         gold = p1.tmp[:gold].to_i
         r = rand(gold*2)
         if r <gold
             move_gold(p1, p2, r/3)
         end
         
         return r/3
    end
    
    def move_gold(p1, p2, gold)
        p1.tmp[:gold] -= gold
        p2.tmp[:gold] += gold
    end
    # ==========================
    #  File system
    # ==========================
    def append_file(fname, content)
         begin
             aFile = File.new(fname,"a")
             aFile.puts content
             aFile.close
         rescue Exception=>e
             logger.error e
         end
    end
    def get_msg_file(ch)
        if (ch.class == Fixnum)
            id = ch.to_i
            if id < 0 
                dir = "chat" if id == -1 
                dir = "rumor" if id == -2 
            else
                dir = id/100
            end
        else
            dir = ch
            id=-1 if ch == "chat"
            id=-2 if ch == "rumor"
        end
 
        dir = "/var/wh/message/#{dir.to_s}"  
        FileUtils.makedirs(dir)   
        fname = "#{dir}/#{id}"
        return fname
        
    end
    def delete_msg(ch)
       fname = get_msg_file(ch)
        begin
            if FileTest::exists?(fname) 
                aFile = File.new(fname, "w")
                aFile.puts ""
                aFile.close
            end
        
        rescue Exception=>e
             logger.error e
        end
    end
    
    def public_channel
        ["chat", "rumor"]
    end
    def system_channel
        ["sys", "rumor"]
    end
    def query_msg(uid, ch_array, delete=false)
        d = ""
        # time = t[:time]
        data = query_filedata(uid)
        if data
            lastread = get_prop(data, "lastread")
             # p "=>last read = #{lastread.inspect}, data=#{data}"
            if lastread.class==String
                lastread= JSON.parse(lastread)
            end
        end
            
        lastread = {} if !lastread
        # p "=>last read = #{lastread.inspect}, #{lastread['191']}, #{lastread["191"]},  #{lastread["191"]}"
        
        ch_array.each{|ch|
            _t= lastread[ch.to_s]
            # p "_t=#{_t}, ch=#{ch}, #{lastread[ch.to_s]}"
            if _t
                t = Time.at(_t)
            else
                if system_channel.include?ch
                    t = Time.now - 3600*24*7
                else
                   t =   Time.now - 3600*24
                end
            end

            c = {:time=>t}
            # p "ttt=>#{t.inspect}, ch=#{ch.inspect}, pch=#{public_channel.inspect}"
            if public_channel.include?ch
      
                r = get_public_msg(ch, c)
                d += r[:data]
                if (r[:time] && (r[:time] <=> t)>0)
                    # c[:time] = time
                    lastread[ch.to_s] = r[:time].to_f+0.000001 
                end
            else
      
                r = get_msg(ch, delete, c)
                d += r[:data]
                # p "->query_msg r=#{r.inspect}, t=#{t.inspect}, data=#{r[:data]}"
                lastread[ch.to_s] = r[:time].to_f+0.000001 if r[:time] && (r[:time] <=> t) > 0
            end
        }
        # p "=>lastread=#{lastread}"
        set_prop(data, "lastread", lastread)
        save_filedata(uid, data)
        # delete_msg(ch)
        # p "===>d=#{d}"
        return d
    end
    def take_msg(uid,ch_array, t)
        query_msg(uid, ch_array, t, true)
    end
    
    def get_public_msg(ch, t)
        get_msg(ch, false, t)
    end
    def get_msg(ch, delete=false, context_time=nil)
        ret = {
            :data => ""
        }
        sys_msg = system_channel.include?ch
          fname=get_msg_file(ch)
         time  = nil
         if context_time
             time = context_time[:time]
         end
         # p "ch=#{ch}"
         # p "====>context time #{time.inspect}, delete=#{delete}, filename=#{fname}"
        begin
            if FileTest::exists?(fname)   
                      # aFile = File.new(fname,"r")
                if delete 
                   open(fname, "r+") {|f|
                       ret[:data] = f.read
                       f.seek(0)
                       # f.write("") 
                       f.truncate(0)
                   }
                   p "===>messsage: #{ret[:data]}"
                        if sys_msg
                               ret[:data] = ret[:data].gsub(/^(\[....-..-.. ..:..).*?(\])/){|s| $1+$2}
                        else
                               ret[:data] = ret[:data].gsub(/^\[.*?\]/, "") 
                        end
                
                else
                    p "filename=#{fname}"
                    ret[:data] = ""
                    file=File.open(fname,"r")  
                    t = nil      
                    ar = []
                    file.each_line do |line|
                        ar.push line
                    end
                    ar.reverse!
                    if ar.size >0
                        md = /^\[(.*?)\](.*)$/.match(ar[0])
                       if md && md[1] 
                        _t =  Time.parse(md[1]) 
                        ret[:time] = _t if (_t <=> time) >0
                        end
                    end
                    ar.each{|line|
                        # p "line = #{line}"
                        md = /^\[(.*?)\](.*)$/.match(line)
                        t = Time.parse(md[1])
                        # p "==>msg time=#{ret[:time].inspect} #{ret[:time].to_f}"
                        # p "context time #{time.to_f}"
                         p "md1=#{md[1].inspect}==>md2=#{md[2].inspect}"
                        # p t <=> time
                         p "sys_msg=#{sys_msg},#{md[1].to(15)} "
                   
                        if ( time && t&& (t <=> time) > 0 ) or time==nil
                            # p "=====>111"
                            #                              p "[#{md[1].to(15)}]#{md[2]}\n"+ret[:data] 
                            if sys_msg
                                
                                ret[:data] = "[#{md[1].to(15)}]#{md[2]}\n#{ret[:data]}"
                                # p ret[:data]
                            else
                                ret[:data] = "#{md[2]}\n"+ret[:data] 
                            end
                        else 
                            break
                        end
                    }
                    # context_time[:time] = t
                    file.close
                 
                end
                   
                 
                      # aFile.close
            end
        rescue Exception=>e
             logger.error e
             p "==>exception #{e.inspect}"
        end
        p "ret=#{ret.inspect}"
        return ret
    end
    def send_msg(ch, m, type='')
        fname = get_msg_file(ch)
        stype=""
        case ch
        when -1:stype="[聊天]"
        when "chat":stype="[聊天]"
        when -2:stype="[江湖传闻]" 
        when "rumor":stype="[江湖传闻]"
        end
        
        case type
        when "task":stype+="[任务]"
        end
        
        time = Time.now
        st =  "#{time.strftime("%Y-%m-%d %H:%M:%S")}.#{time.usec.to_s[0,2]}"
        msg = "[#{st}]#{stype}#{m}<br/>"
  p "==>send msg #{msg}"
        append_file(fname, msg)               
    end
    
    def delete_flag(uid, f)
        id = uid.to_i
        dir = id/100
        fname = "/var/wh/userdata/#{dir.to_s}/#{id}/flag/#{f}"
        File.delete(fname)
    end
    def get_flag(uid, f)
        id = uid.to_i
        dir = id/100
        fname = "/var/wh/userdata/#{dir.to_s}/#{id}/flag/#{f}"
        if FileTest::exists?(fname) 
            return true
        else 
            return false
        end 
    end
    def set_flag(uid, f)
        id = uid.to_i
         dir = id/100
        dir = "/var/wh/userdata/#{dir.to_s}/#{id}/flag"
        FileUtils.makedirs(dir)
        fname = "#{dir}/#{f}" 
        begin
            if !FileTest::exists?(fname)   
                      aFile = File.new(fname,"w")
                      aFile.close
            end
        rescue Exception=>e
             logger.error e
        end
        
    end
    
    def query_filedata(uid)
        json = {}
        id = uid.to_i
         dir = id/100
        dir = "/var/wh/userdata/#{dir.to_s}/#{id}"
        FileUtils.makedirs(dir)
        fname = "#{dir}/jsondata" 
        p "filename #{fname}"
        
        begin
            if FileTest::exists?(fname) 
                data= nil  
                open(fname, "r") {|f|
                       data = f.read
                       # f.seek(0)
                       # f.write("") 
                       # f.truncate(0)
                   }
                   p "data=#{data.inspect}"
                   json = JSON.parse(data) if data
            end
        rescue Exception=>e
             logger.error e
             p e.inspect
        end
        
        return json
        
    end
    
    def save_filedata(uid, data)
        p "save_filedata #{data.inspect}"
        json = data.to_json
        p "save_filedata json=#{json}"
        id = uid.to_i
         dir = id/100
        dir = "/var/wh/userdata/#{dir.to_s}/#{id}"
        FileUtils.makedirs(dir)
        fname = "#{dir}/jsondata" 
        begin
           
                open(fname, "w+") {|f|
                       f.write(json)
                   }
                 
            
        rescue Exception=>e
             logger.error e
        end
        

    end
    