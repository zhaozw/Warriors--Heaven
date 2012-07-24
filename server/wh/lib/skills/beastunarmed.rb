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
     "猛獣アタック"
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
               :action =>"$Nが$nの$l頭で突いた",
               :damage => 10
               #:damage_type=>""
           },
           {
               # :level=>10,
               :level=>5,
               :action =>"$Nが$nの$lに強く噛んでた",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>20,
               :level=>10,
               :action =>"$Nが爪を高く上げて振り、強く$nの$lにつかんだ",
               :damage =>30
               #:damage_type=>""
               
           },
           {
               # :level=>30,
               :level=>20,
               :action =>"$Nが飛んで、$nの$lに飛びかかった",
               :damage =>30
               #:damage_type=>""
               
           },
           {
               # :level=>50,
               :level=>30,
               :action =>"$Nが急に方向を変え、しっぽで$nの$lをアタック",
               :damage =>50
               #:damage_type=>""
               
           },
           {
               :level=>70,
               :action =>"$Nが後爪で地面を掘り、急に低い声で叫んで、$nに飛びかかり、あなたの$lを噛ん
だ",
               :damage =>50
               #:damage_type=>""
               
           },
           {
               :level=>90,
               :action =>"$Nが怒号して、木の葉まで震動させた。$nがぼっとしているところに、既に飛びかか
れた",
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
