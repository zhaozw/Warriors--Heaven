#require 'utility.rb'
require 'skills/skill.rb'

class Unarmed < Game::Skill
    
    # def initialize
    #     super
    #     set("category", "basic")
    #     set("dname", "基本拳脚")
    # end
    
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
     "基本拳法"
   end


   # def power(context)
   #   # context[:user].ext[:str] * @skill[:level]
   #  # damage(context)
   #    p = @skill[:level] * @skill[:level]  * @skill[:level] /3 
   #    str  = context[:user].tmp[:str]
   #    return  (p + context[:user].tmp[:str]+1) / 30 *      (( str+1)/10)
   # end
    
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
               :action =>"$Nが$nの$lにげんこつを振り上げた",
               :damage => 10,
               #:damage_type=>""
           },
           {
               # :level=>10,
               :level=>5,
<<<<<<< HEAD
               :action =>"$Nが$nの$lに強くキックした",
=======
               :action =>"$N往$n的$l狠狠地踢了一脚",
>>>>>>> master
               :damage =>20,
               #:damage_type=>""
               
           },
           {
               # :level=>20,
               :level=>10,
<<<<<<< HEAD
               :action =>"$Nが$nの$lに強くキックした",
=======
               :action =>"$N往$n的$l狠狠地踢了一脚",
>>>>>>> master
               :damage =>30,
               #:damage_type=>""
               
           },
           {
               # :level=>30,
               :level=>20,
<<<<<<< HEAD
               :action =>"$Nが$nのSlにげんこつでアタックした",
=======
               :action =>"$N挥拳攻击$n的$l",
>>>>>>> master
               :damage =>30,
               #:damage_type=>""
               
           },
           {
               # :level=>50,
               :level=>30,
<<<<<<< HEAD
               :action =>"SNが$nの$lを掴む",
=======
               :action =>"$N往$n的$l一抓",
>>>>>>> master
               :damage =>50,
               #:damage_type=>""
               
           },
           {
               # :level=>70,
               :level=>50,
<<<<<<< HEAD
               :action =>"$Nがげんこつで$nの$lをたたく",
=======
               :action =>"$N提起拳头往$n的$l捶去",
>>>>>>> master
               :damage =>50,
               #:damage_type=>""
               
           },
           {
               # :level=>90,
               :level=>70,
<<<<<<< HEAD
               :action =>"$Nが$nの$lを定めて強くげんこつを振り上げた",
=======
               :action =>"$N对准$n的$l用力挥出一拳",
>>>>>>> master
               :damage =>90,
               #:damage_type=>""
               
           },
          {
               :level=>100,
<<<<<<< HEAD
               :action =>"$Nが$nの$lに強くキックした",
=======
               :action =>"$N往$n的$l狠狠地踢了一脚",
>>>>>>> master
               :damage =>100,
               #:damage_type=>""
               
           }
           
          ]
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
