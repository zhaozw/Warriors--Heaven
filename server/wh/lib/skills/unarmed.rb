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

   def damage(context)   # only for calculation, "render" function will make real damage
       user = context[:user]
       a = getAction
       d = a[:damage] + user.tmp[:str]
      
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
      actions[i-1][:index] = i
     a = actions[i-1]
   end
   
   def cost_stam(context)
       p ("power #{power(context)}")
       p ("power^1/3 #{power(context)**(1.0/3.0)}")
       p = power(context)**(1.0/3.0)
       if (p == 0)
           return 10
        end
       stam_cost = 10/(p)
       stam_cost  = stam_cost.to_i
      
        if stam_cost == 0 
            stam_cost = 1
        #elsif stam_cost == Infinity
        #    stam_cost = 10
        end
        
        return stam_cost
   end
   

    
   def doDamage(context)
        # damage
        d = damage(context)                
     #   context[:target].set_temp("hp", context[:target].query_temp("hp")-d)
        context[:target].tmp[:hp] -= d
        # cost stamina
        cs = cost_stam(context)
        #context[:user].set_temp("stam", context[:user].query_temp("stam") - cs)
        context[:user].tmp[:stam] -= cs
        context[:msg] = damage_msg(d, type) + "(体力-#{cs})"
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
