class Daofa < Game::Skill 
#基本刀法
   def for
       return "attack blade"
   end
     
    def category
       "basic"
   end
   def type 
       return "blade"
   end
   
   def dname
       "基本刀法"
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