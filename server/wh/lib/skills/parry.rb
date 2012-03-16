class Parry < Skill
  #  "基本招架" 
    def for
       "parry" 
   end
   
   def type
       return "unarmed"
   end
   
   def desc
      "基本招架" 
   end
   
   def power(context)
        
      context[:user].ext[:str] * @skill[:level]
   end
    
   def defense(context)
       return context[:user].ext[:str] +  @skill[:level]
   end 
    
   def doParry(context)
        context[:msg] += "被$N挡开"
   end
end