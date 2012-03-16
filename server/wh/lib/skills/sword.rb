class Sword < Skill 
#基本剑法
   def for
       return "attack parry"
   end
   
   def type 
       return "sword"
   end
   
   def damage(context)
       userext = context[:user].ext
       thisskill =  @skill
       
       d = thisskill[:level] * userext[:str] + userext[:str]
      
   end
    
   def speed(context)
       thisskill =  @skill
       thisskill[:level] * 2
   end

end