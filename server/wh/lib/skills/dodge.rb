require 'skills/skill.rb'
class Dodge < Game::Skill
    
   def type
       return "unarmed"
   end
 
   def category
       "basic"
   end
   def for
       "dodge"
   end
   
   def dname
       "基本避け"
   end
   

   
    # def power( context)
    #     #dext = dext - context[:user].query_load() 
    #     p = @skill[:level] * @skill[:level]  * @skill[:level] /3 
    #   return  (p + context[:user].tmp[:exp]+1) / 30 *      ( (context[:user].tmp[:dext]+1)/10)
    # end
    
    def speed (context)
        context[:user].tmp[:dext].to_i+@skill[:level]
    end
    
    def dodge_actions
        [
            "ただし、$Nの体から何寸ずれていた。\n",
            "ただし、$Nに賢く避けられた。\n",
            "ただし、$Nが体を傾け、避けた。\n",
            "ただし、$Nにタイムリーに避けられた。\n",
            "ただし、$Nが既に準備したので、慌てずに避けた。\n",
        ]
    end

    def cost_stam(context)
       p = power(context)**(1.0/3.0)
       if (p == 0)
           return 10
        end
       stam_cost = 10/(p)
           stam_cost  = stam_cost.to_i
        if stam_cost == 0 
            stam_cost = 1
        end
        return stam_cost
   end
   

    
    
end