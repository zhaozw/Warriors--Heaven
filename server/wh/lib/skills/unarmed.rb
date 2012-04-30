#require 'utility.rb'
require 'skills/skill.rb'

class Unarmed < Game::Skill
    # 基本拳脚
   def for
       return "attack parry"
   end
   def category
       "basic"
   end
   def type 
       return "unarmed"
   end
   
   def dname #display name
     "基本拳脚"
   end


   def power(context)
     # context[:user].ext[:str] * @skill[:level]
    # damage(context)
      p = @skill[:level] * @skill[:level]  * @skill[:level] /3 
      str  = context[:user].tmp[:str]
      return  (p + context[:user].tmp[:str]+1) / 30 *      (( str+1)/10)
   end
    
   def speed(context)
       thisskill = @skill
       thisskill[:level] * 2 + context[:user].tmp[:dext].to_i
   end
   
   def defense(context)
       thisskill = @skill
       return thisskill[:level]
   end

   def attack_actions
       [
           {
               :level=>0,
               :action =>"$N一拳挥向$n的$l",
               :damage => 10
               #:damage_type=>""
           },
           {
               :level=>10,
               :action =>"$N往$n的$l狠狠地踢了一脚",
               :damage =>20
               #:damage_type=>""
               
           }
          ]
   end

 
   


    

   
   def doAttack(context)
       a = getAction
        target = context[:target]
        p "action=#{a}"

        
        
        # generate msg
        #context[:msg] += translate_msg(a[:action], context)
        # TODO translate arabic number to Chinse e.g.“第三十六式”
        context[:msg] += action_msg(a)
   end

end
