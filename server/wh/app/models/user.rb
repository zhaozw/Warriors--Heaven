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
                    v..data.save!
                    self[:cached] = false
                end
                
            }
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
    
    # only include worn equipment
    def query_equipment(position)
        if !self[:equipments]
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
        
        return self[:equipments][position.to_sym]
        
    end

end
