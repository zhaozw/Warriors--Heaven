class Parry < Skill
  #  "基本招架" 
    def for
       "parry" 
   end
   
   def type
       return "unarmed"
   end
   
   def dname
      "基本招架" 
   end
   
   def power(context)
       p = @skill[:level] * @skill[:level]  * @skill[:level] /3 
      return  (p + context[:user].ext[:exp]+1) / 30 *      ( (context[:user].ext[:str]+1)/10)
   end
    
   def defense(context)
       return context[:user].ext[:str] +  @skill[:level]
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
   
   def doParry(context)
        # cost stamina
            cs = cost_stam(context)
        context[:user].tmp[:stam] -= cs
        
        
        context[:msg] += "被$N挡开(体力-#{cs})"
   end
end