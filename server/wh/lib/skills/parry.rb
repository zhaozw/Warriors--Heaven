class Parry < Game::Skill
  #  "基本招架" 
    def for
       "parry" 
   end
   
   def category
       "basic"
   end
   
   def type
       return "unarmed"
   end
   
   def dname
      "基本受け止め" 
   end
   
   # def power(context)
   #     p = @skill[:level] * @skill[:level]  * @skill[:level] /3 
   #    return  (p + context[:user].tmp[:exp]+1) / 30 *      ( (context[:user].tmp[:str]+1)/10)
   # end
    
   def defense(context)
       return context[:user].tmp[:str] +  @skill[:level]
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
   
   # def doParry(context)
   # 
   # end
end