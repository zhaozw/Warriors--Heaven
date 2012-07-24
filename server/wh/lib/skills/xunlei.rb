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
               :action =>"$Nがあっという間で5拳を上げて、$nをアタックした",
               :damage => 50,
               :cost_stam => 20
               #:damage_type=>""
           },
      
      ]
   end
   
   def perform(context)
       # add more damage
       context[:user].tmp[:apply_damage] += 20
       # enhance chance to hit
       context[:user].tmp[:apply_attack] += 30
   end
   
   def image
       "skills/xunlei.jpg"
   end

 
   


    

   
 

end
