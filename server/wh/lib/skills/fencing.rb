require 'skills/skill.rb'
class Fencing < Game::Skill 
#基本剑法
   def for
       return "attack parry"
   end

   def category
       "basic"
   end
   
   def type 
       return "fencing"
   end
   
   def dname
       "基本剣法"
   end
   
 
   
   # def damage(context)
   #     userext = context[:user].ext
   #     thisskill =  @skill
   #     
   #     d = thisskill[:level] * userext[:str] + userext[:str]
   #    
   # end
    
   def defense(context)
        return context[:user].tmp[:str] +  @skill[:level]
   end
   
   def speed(context)
       thisskill =  @skill
       thisskill[:level] * 2
   end

   def attack_actions
       [
           {
               :level=>0,
               :action =>"$Nが$nの$lに突き刺した",
               :damage => 10
               #:damage_type=>""
           },
           {
               # :level=>10,
               :level=>5,
               :action =>"$Nが剣をあげて、$nの$I強く振った。",
               :damage =>20
               #:damage_type=>""
               
           }
          ]
   end



end