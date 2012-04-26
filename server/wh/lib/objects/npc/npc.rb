require 'objects/livingobject.rb'


class Npc < LivingObject
    def initialize
        setup
    end
    
    def isUser
        false
    end
    def tmp
        @temp
    end
    def setup_skill
        @skills = {}
    end
    def setup_temp
        @temp = {}
    end
    
    def setup
        setup_temp
        setup_skill
        setup_equipment
    end
    def set_skill(name, level, tp)
        s = load_skill(name)
        if (!s.data)
            s.set_data({
                :skname=>name,
                :level=>level,
                :tp => tp
                })
        else
            d = s.data
            d[:skname] = name
            d[:level] = level
            d[:tp] = tp
        end
        if (!@skills)
            @skills = {}
        end
        @skills[name] = s
    end
    
    def query_all_skills
        return @skills.values
    end
    
    def query_skill(skillname)
        if (!@skills)
            setup_skill
        end
        return @skills[skillname]
=begin
        # find
           target_skill = nil
           for skill in @skills.values
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
=end
    end
    
    def query_temp(name)
        if (!@temp)
            setup_temp
        end
        return @temp[name]
    end
    
    def set_temp(name, value)
        if (!@temp)
            setup_temp
        end
        @temp[name] = value
    end
    
    def set_equipment(position, eq)
        if (!@eqs)
            @eqs = {}
        end
        @eqs[position] = eq
    end
    def setup_equipment
    end
    
    def query_equipment(position)
    end
    
    def [](n)
        @temp[n]
    end
    
    def []=(n, v)
        @temp[n] = v
    end
  
end