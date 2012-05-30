#require 'utility.rb'
require 'skills/skill.rb'

class Beastunarmed < Game::Skill
    
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
     "猛兽攻击"
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
               :action =>"$N一头顶向$n的$l",
               :damage => 10
               #:damage_type=>""
           },
           {
               :level=>10,
               :action =>"$N往$n的$l狠狠地咬去",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               :level=>20,
               :action =>"$N挥动利爪，狠狠的抓向$n的$l",
               :damage =>30
               #:damage_type=>""
               
           },
           {
               :level=>30,
               :action =>"$N跳起来，向$n的$l猛扑过去",
               :damage =>30
               #:damage_type=>""
               
           },
           {
               :level=>50,
               :action =>"$N忽然转过身，尾巴向$n的$l扫去",
               :damage =>50
               #:damage_type=>""
               
           },
           {
               :level=>70,
               :action =>"$N用后爪刨了一下地面，忽然低吼一声向$n扑来，咬向你的$l",
               :damage =>50
               #:damage_type=>""
               
           },
           {
               :level=>90,
               :action =>"$N怒吼一声，直震得树叶发颤，在$n一愣的功夫, 已扑了上来",
               :damage =>90
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
