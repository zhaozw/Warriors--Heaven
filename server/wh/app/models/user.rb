require 'utility.rb'
class User < ActiveRecord::Base
=begin 
   def initialize
        p "====>init user\n"
        ext
     init_tmp

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
    end
    
    def setSkills(skills)
        self[:userskill] = skills
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
           self[:userskill] = Userskill.find_by_sql("select skid, skname, level, tp from userskills where uid='#{self[:id]}'")
       end 

       return self[:userskill]
    end
    

    
    def query_all_skills
        if (!self[:skills])
            self[:skills] = {}
            s = userskills
            for ss in s
                name = ss[:skname]
                r = load_skill(name)
                r.set(ss)
                self[:skills][name] = r
            end
       end
       return self[:skills].values
    end
    # return skills/skill object
    def query_skill(skillname)
       # p "==> skill name #{skillname}\n"
        
       if !self[:userskill]
           self[:userskill] = Userskill.find_by_sql("select * from userskills where uid='#{self[:id]}'")
       end 
    
  
       
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
        Usereq.new({
            :uid=>self[:id],
            :sid=>self[:sid],
            :eqid=>o.data[:id],
            :eqname=>o.data[:eqname],
            :eqslotnum=>0,
            :wearon=>nil
        }).save!
    end

end
