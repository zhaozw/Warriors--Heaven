#require 'utility.rb'
require 'skills/skill.rb'

class Caoyao < Game::Skill
    
    # def initialize
    #     super
    #     set("category", "basic")
    #     set("dname", "基本拳脚")
    # end
    
    
   def for
       return "caiyao"
   end
   def category
       "other"
   end
   def type 
       return "heal"
   end
   
   def dname #display name
     "草药学"
   end





    


end
