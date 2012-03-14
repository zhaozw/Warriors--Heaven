require 'utility.rb'

class Unarmed
    # 基本拳脚
   def for
       return "attack parry"
   end
   
   def type 
       return "unarmed"
   end
   
   def damage(context)
       userext = context[:userext]
       thisskill = context[:thisskill]
       
       d = thisskill[:level] * userext[:str] + userext[:str]
      
   end
    
   def speed(context)
       thisskill = context[:thisskill]
       thisskill[:level] * 2 + context[:userext][:dext].to_i
   end
   
   def defense(context)
       thisskill = context[:thisskill]
       return thisskill[:level]
   end
   
   def attack_actions
       [
           {
               :level=>0,
               :action =>"$N一拳挥向$n的左脸",
               
               #:damage_type=>""
           },
           {
               :level=>10,
               :action =>"$N一拳挥向$n的右脸",
               
               #:damage_type=>""
               
           }
          ]
   end
   
   def render(context)
       
      level = context[:thisskill][:level]
      actions = attack_actions
      i = 0;
      for a in actions    
         if (a[:level] > level)
             break
         end
         i += 1
      end
     a = actions[i-1]
     
     #context[:msg] += translate_msg(a[:action], context)
      context[:msg] += a[:action]
   end
    
end