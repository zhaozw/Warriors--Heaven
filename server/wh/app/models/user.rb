require 'utility.rb'
class User < ActiveRecord::Base
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
            r = Userext.find_by_sql("select * from userexts where sid='#{sid}'")
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
    def query_skill(skillname)
       if !self[:userskill]
           self[:userskill] = Userskill.find_by_sql("select skid, skname, level, tp from userskills where uid='#{self[:id]}'")
       end 
    
       if (!self[:skills])
            self[:skills] ={}
       end
       
       if (self[:skills][skillname])
           return self[:skills][skillname]
       else
           # find
           target_skill = nil
           for skill in self[:userskill]
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
                return targetObj
            end
       end
      
         
    end
end
