#require 'utility.rb'
require 'skills/skill.rb'

class Literature < Game::Skill
    
    # def initialize
    #     super
    #     set("category", "basic")
    #     set("dname", "基本拳脚")
    # end
    
    
   def for
       return "read write"
   end
   def category
       "other"
   end
   def type 
       return "literature"
   end
   
   def dname #display name
     "读书写字"
   end





    


end
