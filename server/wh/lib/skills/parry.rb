class Parry
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
   
   def damage(userext, userskill)
        0
      
   end
    
   def defense(context)
       return context[:userext][:str] + context[:thisskill][:level]
   end 
    
    
end