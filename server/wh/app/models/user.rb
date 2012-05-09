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

    def setUserext(ext)
        self[:userext] = ext
     #   self[:userext][:_p] = self
    end
    
    def setSkills(skills)
        self[:userskill] = skills
    #    self[:userskill][:_p] = self
    end
    
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
    
    def userskills
        if !self[:userskill]
           self[:userskill] = Userskill.find_by_sql("select * from userskills where uid='#{self[:id]}'")
       end 
#       self[:userskill][:_p] = self
       return self[:userskill]
    end
    

    def loadAllSkills
        p "==>load all skills"
         self[:skills] = {}
            s = userskills
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
        userskills
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
    
    def get_object(o)
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
        end
        
    end
    
    # def update_quest(name, add_progress)
    #     q = query_quest(name)
    #     q[:progress] += add_progress
    # end
    
    def query_quest(quest)
        if (!self[:userquests])
           self[:userquests] = {}; 
       end
       if (!self[:userquests][quest])
           rs = Userquest.find_by_sql("select * from userquests where name='#{quest}' and uid=#{self[:id]}") 
            if (rs[0])
                  self[:userquests][quest] = rs[0]
              end
        end
        
       # self[:userquests][:_p] = self
        #self[:userquests][quest][:_p] = self
       return self[:userquests][quest]
       
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
        @cached= true
       # self[:cached] = true
        $memcached.set(self[:id].to_s, self)
        p "==>cached"
    end
    
    def set_skill(name, lvl, tp)
        skill = query_skill(name)
        if (!skill)
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
           # self[:cached] = false
        else
            skill.set("level", lvl)
            skill.set("tp", tp)
        end
        return skill
    end
    def check_save   
        p "===>changed?=#{changed?.inspect}"
        if (changed?)
            p "==>saving"
            save!
            self[:cached] = false
        end
        
        if self.ext.changed?
            p "saved userext for user #{self[:user]}, #{ext.inspect}"
            self.ext.save!
            self[:cached] = false
        end
        
        if self.userskills
            for us in userskills
                if (us.changed?)
                    us.save!
                    self[:cached] = false
                end
            end   
        end
        
        if self[:userquests]
          self[:userquests].each {|k,v|
                if v.changed?
                    v.save!
                    self[:cached] = false
                end
                
            }
        end
        
        if self[:equipments]
          self[:equipments].each {|k,v|
                if v.data.changed?
                    v.data.save!
                    self[:cached] = false
                end
                
            }
        end
        
        if self[:items]
            for us in self[:items]
                if (us.data)
                    if (us.data.changed?)
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
        r = $memcached.get(id.to_s)

        if r
            p "found in cache!"
        end
     #   r.reset_change if r # need to reset because the value of @changed also cached
        return r if r
        
        p "not found in cache!"
        r = User.find(id)
        r.cache
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
                    eq = Equipment.find(v.to_i)
                    obj = load_obj(eq[:eqname], eq)
                    self[:equipments][k.to_sym] = obj
                }
            end
                     # p "===>@worn_eq=#{@worn_eq}"
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
    
    def delete_item(obj)
        o = remove_item(obj)
        if o
            o.data.delete
        end
       
    end
    def remove_item(obj)
        o = query_item_by_id(obj.data[:id])
              p "==>items33330:#{self[:items].inspect}"
        if !o
            return nil
        end
              p "==>items33331:#{obj[:eqtype]}"
        if obj[:eqtype].to_i !=2
            unwear_equipment(obj)
        else
            p "==>items3333:#{self[:items].inspect}"
            if (self[:items])
                
                 self[:items].delete(o)
                 p "==>items3:#{self[:items].inspect}"
             end
        end
   
        obj[:owner]=nil   
        o[:owner]=nil   
        self[:cached] = false         
        p "==>items21:#{self[:items].inspect}"
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
                # p "==>slot[#{k}]=#{v}, param id=#{params[:id]}"
                if (v.to_i == id.to_i)
               
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
    
    def load_items
        eqs = Equipment.find_by_sql("select * from equipment where owner=#{self[:id]} and eqtype=2")
        self[:items] =[]
        for eq in eqs 
            obj=load_obj(eq[:eqname], eq)
            self[:items].push(obj)
        end
    end
    def query_items
        if !self[:items]
            load_items
        end
        return self[:items]
    end
    
    def query_item_by_id(id)
        eqs = query_items
         p "===> eqs=#{eqs.inspect}"
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
     
     def get_exp(exp)
         levelup = 0
         exp_next_level = (ext[:level]+1)**3
         if (exp_next_level<= ext[:exp]+exp)
             levelup = 1
             ext[:level] += 1
             ext[:exp] = 0
             mh_bonus = rand(ext[:level]/2 )
             mh_bonus = ext[:level]/3 if mh_bonus <= ext[:level]/3
             ext[:maxhp] += mh_bonus
         else
             ext[:exp] += exp
        end
        return levelup
     end
         
end
