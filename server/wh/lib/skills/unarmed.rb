#require 'utility.rb'
require 'skills/skill.rb'

class Unarmed < Skill
    # 基本拳脚
   def for
       return "attack parry"
   end
   
   def type 
       return "unarmed"
   end
   
   def damage(context)   # only for calculation, "render" function will make real damage
       userext = context[:user].ext
       a = getAction
       d = a[:damage] + userext[:str]
      
   end
    
   def power(context)
     # context[:user].ext[:str] * @skill[:level]
     damage(context)
   end
    
   def speed(context)
       thisskill = @skill
       thisskill[:level] * 2 + context[:user].ext[:dext].to_i
   end
   
   def defense(context)
       thisskill = @skill
       return thisskill[:level]
   end
   
   def attack_actions
       [
           {
               :level=>0,
               :action =>"$N一拳挥向$n的左脸",
               :damage => 10
               #:damage_type=>""
           },
           {
               :level=>10,
               :action =>"$N一拳挥向$n的右脸",
               :damage =>20
               #:damage_type=>""
               
           }
          ]
   end
   
   def getAction
       level = @skill[:level]
      actions = attack_actions
      i = 0;
      for a in actions    
         if (a[:level] > level)
             break
         end
         i += 1
      end
     a = actions[i-1]
   end
   
   def doAttack(context)
       a = getAction
        target = context[:target]
        p "action=#{a}"
      # damage
        target.ext[:hp] -= damage(context)
        
        # generate msg
     #context[:msg] += translate_msg(a[:action], context)
      context[:msg] += a[:action]
   end
    
end
