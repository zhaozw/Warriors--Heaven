require 'skills/skill.rb'
class Dodge < Skill
    
   def type
       return "unarmed"
   end
   
   def for
       "dodge"
   end
   
   def damage(context)
       0
      
   end
   
    def power( context)
        #dext = dext - context[:user].query_load() 
        p = @skill[:level] * @skill[:level]  * @skill[:level] /3 
      return  (p + context[:user].ext[:exp]+1) / 30 *      ( (context[:user].ext[:dext]+1)/10)
    end
    
    def speed (context)
        context[:user].ext[:dext].to_i+@skill[:level]
    end
    
    def dodge_actions
        [
            "但是和$N身体偏了几寸。\n",
            "但是被$N机灵地躲开了。\n",
            "但是$N身子一侧，闪了开去。\n",
            "但是被$N及时避开。\n",
            "但是$N已有准备，不慌不忙的躲开。\n",
        ]
    end

    def cost_stam(context)
       p = power(context)
       if (p == 0)
           return 10
        end
       stam_cost = 10/(power(context)**(1.0/3.0))
      
        if stam_cost == 0 
            stam_cost = 1
        elsif stam_cost == Infinity
            stam_cost = 10
        end
        return stam_cost
   end
   
    def doDodge(context)
        srand Time.now.tv_usec.to_i
        a = dodge_actions
    
        
        # cost stamina
             cs = cost_stam(context)
        context[:user].tmp[:stam] -= cs
        
        context[:msg] += a[rand(a.length)] + "(体力-#{cs})"
        
    end
    
    
end