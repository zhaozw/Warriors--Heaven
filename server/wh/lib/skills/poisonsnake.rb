#require 'utility.rb'
require 'skills/skill.rb'

class Poisonsnake < Game::Skill
    
    # def initialize
    #     super
    #     set("category", "basic")
    #     set("dname", "基本拳脚")
    # end
    

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
     "毒蛇攻击"
   end


   # def power(context)
   #   # context[:user].ext[:str] * @skill[:level]
   #  # damage(context)
   #    p = @skill[:level] * @skill[:level]  * @skill[:level] /3 
   #    str  = context[:user].tmp[:str]
   #    return  (p + context[:user].tmp[:str]+1) / 30 *      (( str+1)/10)
   # end
    


   def attack_actions
       [
           {
               :level=>0,
               :action =>"$N盘成一个圈，忽然一口咬向$n的$l",
               :damage => 10
               #:damage_type=>""
           },
           {
               # :level=>10,
               :level=>5,
               :action =>"$N吐了吐红信，往$n的$l狠狠地咬去",
               :damage =>20
               #:damage_type=>""
               
           }

          ]
   end
 
	def hit(context)
		attacker = context[:attacker]
		defenser = context[:defenser]
		action = context[:action]
		defenser.addStatus("中毒中")
		context[:msg]="<div class='poisoned'>$n觉得伤口逐渐发麻, 你中毒了! </div>"
		defenser.set_poisoned("蛇毒", 10)
	end
 
   


    

   
   # def doAttack(context)
   #     a = getAction
   #      target = context[:target]
   #      p "action=#{a}"
   # 
   #      
   #      
   #      # generate msg
   #      #context[:msg] += translate_msg(a[:action], context)
   #      # TODO translate arabic number to Chinse e.g.“第三十六式”
   #      context[:msg] += action_msg(a)
   # end

end
