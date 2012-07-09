require 'objects/character.rb'


module Npc 
    include Character
    def initialize
        super
        setup
    end
    
    
    def isUser
        false
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
    
    # def query_temp(name)
    #       # if (!@temp)
    #       #     setup_temp
    #       # end
    #       # return @temp[name]
    #       return tmp[name.to_sym]
    #   end
    #   
    #   def set_temp(name, value)
    #       # if (!@temp)
    #       #     setup_temp
    #       # end
    #       # @temp[name] = value
    #       @temp[name.to_sym] = value
    #   end
    
    # def set_equipment(position, eq)
    #     if (!@eqs)
    #         @eqs = {}
    #     end
    #     @eqs[position.to_sym] = eq
    # end
    # 
    # def setup_equipment
    # end
    # 
    # def query_equipment(position)
    #     if (!@eqs)
    #         @eqs = {}
    #     end
    #     return @eqs[position.to_sym]
    # end
    # 
    # def query_all_equipments
    #     return @eqs
    # end
    def [](n)
        @temp[n]
    end
    
    def []=(n, v)
        @temp[n] = v
    end
    
    def hp(hp=nil)
        if (hp != nil)
            temp[:hp] = hp
        end
        tmp[:hp]
    end
    
     def to_hash
         h = super
         h = h.merge(@temp).merge({
             :race=>race
         })
     end
     
    def get(n)
        tmp[n.to_sym]
    end
    
    def set(n,v)
       tmp[n.to_sym] = v
    end
    
    def var
        tmp
    end
    
    def ext
        tmp
    end
     def release_poisoned
         # ext.delete_prop("poisoned")
         temp[:poisoned]
     end
     def set_poisoned(poison_name, amount)
         # ext.set_prop("poisoned", {:name=>poison_name, :amount=>amount, :time=>Time.now})
         ext[:poisoned] = {:name=>poison_name, :amount=>amount, :time=>Time.now}
     end
     def get_poisoned
         # return ext.get_prop("poisoned")
         return ext[:poisoned]
     end
  
    def get_prop
        return nil
    end
    def set_prop
        
    end
end