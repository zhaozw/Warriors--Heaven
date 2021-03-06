require 'utility.rb'

class User < ActiveRecord::Base
=begin
   def initialize(hash)
        p "====>init user\n"
  #      change
       # ext
     #init_tmp

    end

    def init_tmp
        self[:usertmp] = {};
        
         self[:usertmp][:exp] = ext[:exp]
         self[:usertmp][:str] = ext[:str]
         self[:usertmp][:hp] = ext[:maxhp]
         self[:usertmp][:maxhp] = ext[:maxhp]
         self[:usertmp][:dext] = ext[:dext]
         self[:usertmp][:stam] = ext[:stam]
         self[:usertmp][:maxst] = ext[:maxst]
    end
        def tmp
        if (!self[:userext]) 
            ext
        end
        if (self[:usertmp] == nil)
            init_tmp
        end
         return self[:usertmp]
    end
    
    def query_temp(vname)
        return tmp[vname]
    end
=end

    def setUserext(ext1)
        self[:userext] = ext1
     #   self[:userext][:_p] = self
    end
    
    # def setSkills(skills)
    #     # self[:userskill] = skills
    #     self[:skills] = skillss
    # #    self[:userskill][:_p] = self
    # end
    
    def ext
        if (self[:userext])
            return self[:userext]
        else
            r = Userext.find_by_sql("select * from userexts where uid='#{self[:id]}'")
            if (r.size > 0)
                setUserext(r[0])
            end
        end
        return self[:userext]
    end
    
    def query_weapon(position)
        
    end
    


    def loadAllSkills
        p "==>load all skills"
         self[:skills] = {}
            # s = userskills
            s = Userskill.find_by_sql("select * from userskills where uid='#{self[:id]}'") 
            for ss in s
                name = ss[:skname]
                r = load_skill(name)
                r.set_data(ss)
                self[:skills][name] = r
            end
    end
    def query_all_skills
        if (!self[:skills])
           loadAllSkills
       end
       return self[:skills].values
    end
    def skills
        query_all_skills
    end
    # return skills/skill object
    def query_skill(skillname)
       # p "==> skill name #{skillname}\n"
        
     #  if !self[:userskill]
       #    self[:userskill] = Userskill.find_by_sql("select * from userskills where uid='#{self[:id]}'")
     #  end 
        # userskills
    #p "==>userskills=#{self[:userskill]}"
#          p "==>skills=#{self[:skills].count}"
       if (!self[:skills] || self[:skills].count == 0)
           loadAllSkills
       end

       # p "==>skills=#{self[:skills]}"
       return self[:skills][skillname]
=begin
       if (self[:skills][skillname])
         #  p  "=====>return skill #{self[:skills][skillname]}"
           return self[:skills][skillname]
       else
           # find
           target_skill = nil
           for skill in self[:userskill]
            #    p "==> compare skill name #{skill[:skname]}\n"
               if skill[:skname] == skillname
                   target_skill = skill
                   break
               end
           end
           if (target_skill == nil)
               return nil
           else
                targetObj = load_skill(skillname)
                m = targetObj.method("set")
                m.call(target_skill)
                self[:skills][skillname]= targetObj
                return targetObj
            end
       end
=end
    end
    
 
    # get object (equipment, item, prem)
    def get_obj(o)
        p "==>get obj #{o.inspect}"
        # Usereq.new({
        #       :uid=>self[:id],
        #       :sid=>self[:sid],
        #       :eqid=>o.data[:id],
        #       :eqname=>o.data[:eqname],
        #       :eqslotnum=>0,
        #       :wearon=>nil
        #   }).save!
        
        o.data[:owner] = self[:id]
        o.data.save!
         p "==>save obj #{o.inspect}"
        if self[:objects]
            self[:objects].push(o)
            self[:cached] = false
        end
        
    end
=begin    
    # get item (eqtype=2)
    def get_item(o)
        # Usereq.new({
        #       :uid=>self[:id],
        #       :sid=>self[:sid],
        #       :eqid=>o.data[:id],
        #       :eqname=>o.data[:eqname],
        #       :eqslotnum=>0,
        #       :wearon=>nil
        #   }).save!
        o.data[:owner] = self[:id]
        o.data.save!
        if self[:items]
            self[:items].push(o)
            self[:cached] = false
        end
        
    end
=end    
    # def update_quest(name, add_progress)
    #     q = query_quest(name)
    #     q[:progress] += add_progress
    # end
    
    def query_all_quests()
        if (!self[:userquests])
           self[:userquests] = {}; 
       end
        rs = Userquest.find_by_sql("select * from userquests where  uid=#{self[:id]}")
        rs.each{|r|
                self[:userquests][r[:name].to_sym] = r
            
        }
        set_cached(false)
    
        
        
       # self[:userquests][:_p] = self
        #self[:userquests][quest][:_p] = self
       return self[:userquests]
       
    end
    

    def query_quest(quest)

        if (!self[:userquests])
           self[:userquests] = {}; 
       end
       if (!self[:userquests][quest.to_sym])
           rs = Userquest.find_by_sql("select * from userquests where name='#{quest}' and uid=#{self[:id]}") 
            if (rs[0])
                  self[:userquests][quest.to_sym] = rs[0]
                  set_cached(false)
              end
        end
        
       # self[:userquests][:_p] = self
        #self[:userquests][quest][:_p] = self
       return self[:userquests][quest.to_sym]
       
    end
    
 #   def change
  #      @changed = true
 #       p "====>data chagned!"
 #   end
    
  #  def changed?
  #      p "===>changed=#{@changed.inspect}"
  #      if !@changed
     #       return false
   #     end
   #     return true
   # end
    
   # def discard
   #     @changed = false
   # end
    
    def []=(k,v)
       super 
       p "===>updated"
       #change
    end
    
    def cache
        # @cached= true
       self[:cached] = true
        $memcached.set(self[:id].to_s, self)
        p "==>cached"
    end
    
    def set_skill(name, lvl, tp)
        skill = query_skill(name)
        if (!skill)
            begin
                us =         Userskill.new({
                        :uid        =>  self[:id],
                        :sid        =>  self[:sid],
                        :skid       =>  0,
                        :skname     =>  name,
                        :skdname    => "",
                        :level      =>  lvl,
                        :tp         =>  tp,
                        :enabled    =>  1   
                    })
                us.save!
        

                skill = load_skill(name)
                skill.set_data(us)
                self[:skills][name] = skill
            rescue Exception=>e
                p 
            end
           # self[:cached] = false
        else
            skill.set("level", lvl)
            skill.set("tp", tp)
        end
        return skill
    end
    def remove_attr(a)
        _a = self.attributes
        a.each {|k|
          _a.delete(k)  
          _a.delete(k.to_sym)  
        }
        p "==>_a #{_a.inspect}"
        attributes= _a
        p "==>attributes #{attributes.inspect}"
    end
    def isChanged?(r)
        return false if !r.changed? 
        return true if r.new_record? || r.marked_for_destruction?
        r.changes.each {|k,v|
            p "=>#{k}"
            return true if  r.class.column_names.include?(k)
        }
        return false
       
    end
    def check_save   
        p "===>changed?=#{changed.inspect}, changes=#{changes.inspect}, attributes=#{attributes.inspect}"
        p "==>columns =#{User.column_names.inspect}"
        if (isChanged?(self))
            p "==>saving"
            save!
            self[:cached] = false
        end
        
        p "===>ext changes: #{ext.changes.inspect}"
        p "ext columns:#{ext.class.column_names.inspect}"
        p "include prop = #{ext.class.column_names.include?"prop"}"
        if isChanged?(ext)
            p "saved userext for user #{self[:user]}, #{ext.inspect}"
            self.ext.save!
            self[:equipments] = nil
            self[:cached] = false
        end
        
        if self[:skills]
            for us in self[:skills].values
                us = us.data
                if (isChanged?(us))
                    us.save!
                    self[:cached] = false
                end
            end   
        end
        
        if self[:userquests]
          self[:userquests].each {|k,v|
                if isChanged?(v)
                    v.save!
                    self[:cached] = false
                end
                
            }
        end
        
        if self[:equipments]
          self[:equipments].each {|k,v|
                if v == nil
                    self[:equipments].delete(k)
                else
                    if isChanged?(v.data)
                        v.data.save!
                        self[:cached] = false
                    end
                end
                
            }
        end
=begin        
        if self[:items]
            for us in self[:items]
                if (us.data)
                    if (isChanged?(us.data))
                        p "=>changed=#{us.data.changed.inspect}"
                        p "==>#{us.data.inspect}"
                        us.data.save!
                        self[:cached] = false
                    end
                end
            end
        end
=end
        if self[:objects]
            for us in self[:objects]
                if (us.data)
                    if (isChanged?(us.data))
                        p "=>changed=#{us.data.changed.inspect}"
                        p "==>#{us.data.inspect}"
                        us.data.save!
                        self[:cached] = false
                    end
                end
            end
        end
        
        if !self[:cached] 
              p "==>caching"
            cache
        end
    end
    
  #  def reset_change
   #     @changed = false
  #  end

  #  def save!
      #  p "===>#{self.class},#{super.class}"
  #      super
    #    cache
   # end
    
    def self.get(id)
        flat = false
        r = nil
        if (!get_flag(id, "db_changed")) 
            begin
                r = $memcached.get(id.to_s)
            rescue Exception => e
                logger.error e
                 p e.inspect
             end
            if r
                p "found in cache!"
            end
        else
            flag = true
           
        end

        
     #   r.reset_change if r # need to reset because the value of @changed also cached
        return r if r
        
        p "not found in cache!"
        begin
            r = User.find(id)
            r.cache
        rescue Exception=>e
                p e
        end
        delete_flag(id, "db_changed") if flag
        return r
    end
    
    def load_equipments
        self[:equipments] = {}
            eqslot = ext.get_prop("eqslot")
            p "===>eqslot=#{eqslot}"
            if eqslot
                if eqslot.class == String
                    eqslot = JSON.parse(eqslot)
                end
                eqslot.each{|k,v|
                    if v.class == String
                        ar = v.split("@")
                        obj = query_obj_by_id(ar[1].to_i)
                    else
                        obj = query_obj_by_id(v)
                    end
                    self[:equipments][k.to_sym] = obj
                }
            end
                     # p "===>@worn_eq=#{@worn_eq}"
            return self[:equipments]
    end
    
    def query_obj(name)
        p "=>query_obj #{name}"
        objs = query_all_obj
        for o in objs
            # if name=~/muren/
            #     p "==>obj: #{o.data[:eqname]}"
            # end
            return o if o.data[:eqname] == name
        end
        return nil
    end
    
    def invalidate_all_obj(reload)
        p "===>invalidate objects"
        self[:objects] = nil
        query_all_obj if reload
        set_cached(false)
    end
    def query_all_obj
        p "self objects #{self[:objects].inspect}"
        if !self[:objects]
            self[:objects] = []
            eqs = Equipment.find_by_sql("select * from equipment where owner=#{self[:id]}")
            if eqs and eqs.size>0
                for eq in eqs
                    _eq = Equipment.load_equipment(eq[:eqname], eq)
                    self[:objects].push(_eq)
                end
            end
        end
            
        return self[:objects]
    end
    
    def query_all_equipments
        if !self[:equipments]
            load_equipments
        end
        return self[:equipments]
    end
    # only include worn equipment
    def query_equipment(position)
        if !self[:equipments]
            load_equipments
        end
        
        return self[:equipments][position.to_sym]
        
    end
    
    def delete_obj(obj)
        o = remove_obj(obj)
        if o
            o.data.delete
        end
    end
    
    def set_cached(b)
        self[:cached] = b 
    end
    
    def remove_obj(obj)
        o = query_obj_by_id(obj.data[:id])
              # p "==>items33330:#{self[:items].inspect}"
        if !o
            return nil
        end
              # p "==>items33331:#{obj[:eqtype]}"
        if obj[:eqtype].to_i ==1
            unwear_equipment(obj)
        else
            # p "==>items3333:#{self[:items].inspect}"
            # if (self[:items])
                 # self[:items].delete(o)
                 # p "==>items3:#{self[:items].inspect}"
             # end
        end
        
        if (self[:objects])
            self[:objects].delete(o)
        end
   
        obj[:owner]=nil   
        o[:owner]=nil   
        self[:cached] = false         
        # p "==>items21:#{self[:items].inspect}"
        return o
    end
    
    def unwear_equipment(eq)

        # eq = Equipment.find(id)
        #        obj = load_obj(eq[:eqname], eq)
             
        # max_eq = user_data.ext.get_prop("max_eq").to_i
        eqslot = ext.get_prop("eqslot")
        id  = eq[:id]
        p eqslot
   
        if eqslot
            bFound = false
            if (eqslot.class == String)
                eqslots = JSON.parse(eqslot)
            else
                eqslots = eqslot
            end
            p "===>eqlost=#{eqslots.inspect}"
            eqslots.each{|k,v|
                ar = v.to_s.split("@")
                # p "==>slot[#{k}]=#{v}, param id=#{params[:id]}"
                if (ar[1].to_i == id.to_i)
                    
                    eqslots.delete(k)
                    bFound = true
                    break
                end
            }
            
            if bFound
                p "==>set eqslot:#{eqslot.inspect}"
                ext.set_prop("eqslot", eqslots.to_json)
            end
            
        end
        
    end
=begin    
    def load_items
        # eqs = Equipment.find_by_sql("select * from equipment where owner=#{self[:id]} and eqtype=2")
        eqs = query_all_obj
          p "eqs=#{eqs.inspect}"
        self[:items] =[]
        for eq in eqs 
            p "eq=#{eq.inspect}"
            self[:items].push(eq) if eq.data[:eqtype].to_i==2
        end
    end

    def query_items
        p "=>items=#{self[:items]}"
        # if !self[:items]
            load_items
        # end
        return self[:items]
    end
=end

    def query_items
        eqs = query_all_obj
          # p "eqs=#{eqs.inspect}"
        # self[:items] =[]
        ret =[]
        for eq in eqs 
            # p "eq=#{eq.inspect}"
            # self[:items].push(eq) if eq.data[:eqtype].to_i==2
            ret.push(eq) if eq.data[:eqtype].to_i==2
        end
        return ret
    end
    
    def query_obj_by_id(id)
        p "==>query obj by id #{id}"
        eqs = query_all_obj
         # p "===> eqs=#{eqs.inspect}"
         for eq in eqs
             if eq.data[:id] == id
                 return eq
             end
         end
         p "==> not found"
         return nil
    end
    def query_item_by_id(id)
        eqs = query_items
         # p "===> eqs=#{eqs.inspect}"
         for eq in eqs
             if eq.data[:id] == id
                 return eq
             end
         end
         return nil
    end
    def query_item(name)
         eqs = query_items
          p "===> eqs=#{eqs.inspect}"
         for eq in eqs
             if eq.data[:eqname] == name
                 return eq
             end
         end
         return nil
     end
     
     
     def query_team
         if !self[:team]
            team = Team.find_by_sql("select * from teams where owner='#{self[:id]}'")
           
            self[:team] = {
              
            }
            if team and team.size > 0
            
                t = team[0]
                self[:team][:data]=team[0]
                prop = JSON.parse(t[:prop])
        
                for i in 0..7
                    if prop[i.to_s]
                        u = User.get(prop[i.to_s].to_i)
                        if u
                            u.ext
                            self[:team][i.to_s] = u
                        end
                    end
                end
            end
        end
        return self[:team]
    
     end
     

end
