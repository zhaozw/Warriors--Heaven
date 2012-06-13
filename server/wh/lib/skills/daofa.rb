require 'skills/skill.rb'
class Daofa < Game::Skill 
#基本刀法
   def for
       return "attack blade"
   end
     
    def category
       "basic"
   end
   def type 
       return "daofa"
   end
   
   def dname
       "基本刀法"
   end
   

    
   def speed(context)
       thisskill =  @skill
       thisskill[:level] * 2
   end
   def attack_actions
       [
           {
               :level=>0,
               :action =>"$N一刀劈向$n的$l",
               :damage => 10
               #:damage_type=>""
           },
           {
               # :level=>10,
               :level=>5,
               :action =>"$N举刀向$n的$l狠狠地砍去",
               :damage =>20
               #:damage_type=>""
               
           }
          ]
   end
end