class Sword
#基本剑法
   def for
       return "attack defense"
   end
   
   def type 
       return "sword"
   end
   
   def damage(context)
       userext = context[:userext]
       thisskill = context[:thisskill]
       
       d = thisskill[:level] * userext[:str] + userext[:str]
      
   end
    
   def speed(context)
       thisskill = context[:thisskill]
       thisskill[:level] * 2
   end

end