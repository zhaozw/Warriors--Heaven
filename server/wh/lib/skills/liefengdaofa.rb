require 'skills/daofa.rb'
class Liefengdaofa < Daofa 

   def for
       return "attack blade"
   end
    
   def category
       "common"
   end
   

   
   def dname
       "烈風刀法"
   end
   
   def desc
       "崆峒派刀法"
   end
    
   def needResearchPoint
       100
   end
   
   def researchConditionDesc
       "基本刀法>10级"
   end
   
   def mengpai
       "dongying" # 东瀛
   end
   
   def checkResearchCondition(context)
       user = context[:user]
       skill = user.query_skill("blade")

       if (!skill or skill.data[:level] <= 10 )
           context[:msg] += "你的基本刀法功夫还不够，无法参悟书中奥义"
           return false
       end
       return true
   end
   
   def image
       "other/zhujian.png"
   end
   # def damage(context)
   #     userext = context[:user].ext
   #     thisskill =  @skill
   #     
   #     d = thisskill[:level] * userext[:str] + userext[:str]
   #    
   # end
    
   def speed(context)
       thisskill =  @skill
       thisskill[:level] * 2
   end
      def attack_actions # from liuhe-da-fa
       [
           {
               :level=>0,
               :name=>"呵壁问天",
               :action =>"$Nが大声を上げて、続けざまに刀を振り、$nの$Iを切った",
               :damage => 10
               #:damage_type=>""
           },
           {
               # :level=>10,
               :level=>5,
               :name=>"气盖河山",
               :action =>"$Nが素早く刀を振っていた。勢いが非常に強くて、$nの周辺に激しく切っていた",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>20,
               :level=>10,
               :name=>"天地乍合",
               :action =>"$Nが急に$nの近くまで行って、素早く刀で強く切っていた",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>30,
               :level=>20,
               :name=>"贰斩",
               :action =>"$Nが手を背の後に回して刺した。守るために後退したが、殺意をひそかに隠れてい
る",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>50,
               :level=>30,
               :name=>"砂纹",
               :action =>"$N追步平刺，如松之劲，如风之轻，刚柔兼济",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>70,
               :level=>50,
               :name=>"魔熊",
               :action =>"$N一剑横撩，宛如松涛阵阵袭来，让人无处可逃",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>100,
               :level=>70,
               :name=>"居合斩",
               :action =>"$N一剑横撩，宛如松涛阵阵袭来，让人无处可逃",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>130,
               :level=>100,
               :name=>"龙卷风",
               :action =>"$N一剑横撩，宛如松涛阵阵袭来，让人无处可逃",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>170,
               :level=>130,
               :name=>"鬼斩",
               :action =>"$N一剑横撩，宛如松涛阵阵袭来，让人无处可逃",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>200,
               :level=>170,
               :name=>"艳美魔夜不眠鬼斩",
               :action =>"$N一剑横撩，宛如松涛阵阵袭来，让人无处可逃",
               :damage =>20
               #:damage_type=>""
               
           }
          ]
   end

end