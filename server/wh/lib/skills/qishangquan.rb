class Qishangquan < Skill 
#基本剑法
   def for
       return "attack unarmed"
   end
     def category
       "common"
   end
   def type 
       return "unarmed"
   end
   
   def dname
       "七伤拳"
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