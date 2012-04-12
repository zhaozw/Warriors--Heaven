class Huyuezhan < Skill 
#基本剑法
   def for
       return "attack blade"
   end
    
   def category
       "common"
   end
   def type 
       return "blade"
   end
   
   def dname
       "弧月斩"
   end
   
   def image
       "skills/huyuezhan.png"
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