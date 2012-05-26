#require 'utility.rb'
require 'skills/skill.rb'

class Xunlei < Game::Skill
    
    # def initialize
    #     super
    #     set("category", "basic")
    #     set("dname", "基本拳脚")
    # end
    
    # 基本拳脚
   def for
       return "attack"
   end
   def category
       "premier"
   end
   
   def type 
       return "unarmed"
   end
   
   def dname #display name
     "迅雷"
   end



    


   def attack_actions
       [
           {
               :level=>0,
               :action =>"$N在电光火石之间攻出五拳，击向$n",
               :damage => 100
               #:damage_type=>""
           },
      
      ]
   end
   
   def perform(context)
       context[:user].tmp[:apply_damage] += 100
   end
   
   def image
       "skills/xunlei.jpg"
   end

 
   


    

   
 

end
