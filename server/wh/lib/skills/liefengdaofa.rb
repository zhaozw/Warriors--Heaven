require 'skills/daofa.rb'
class Liefengdaofa < Daofa 

   def for
       return "attack blade"
   end
    
   def category
       "common"
   end
   

   
   def dname
       "烈风刀法"
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
      return true
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
      def attack_actions
       [
           {
               :level=>0,
               :name=>"三十六烦恼凤",
               :action =>"$N剑尖上撩，招式轻灵，犹如白云飘来",
               :damage => 10
               #:damage_type=>""
           },
           {
               :level=>10,
               :name=>"飞龙火焰",
               :action =>"$N一剑直劈，招式厚重，犹如重重青山",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               :level=>20,
               :name=>"鹰波",
               :action =>"$N一剑轻削，轻柔如风，无影无踪",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               :level=>30,
               :name=>"贰斩",
               :action =>"$N翻手倒刺，以退为守，暗藏杀机",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               :level=>50,
               :name=>"砂纹",
               :action =>"$N追步平刺，如松之劲，如风之轻，刚柔兼济",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               :level=>70,
               :name=>"魔熊",
               :action =>"$N一剑横撩，宛如松涛阵阵袭来，让人无处可逃",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               :level=>100,
               :name=>"居合斩",
               :action =>"$N一剑横撩，宛如松涛阵阵袭来，让人无处可逃",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               :level=>130,
               :name=>"龙卷风",
               :action =>"$N一剑横撩，宛如松涛阵阵袭来，让人无处可逃",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               :level=>170,
               :name=>"鬼斩",
               :action =>"$N一剑横撩，宛如松涛阵阵袭来，让人无处可逃",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               :level=>200,
               :name=>"艳美魔夜不眠鬼斩",
               :action =>"$N一剑横撩，宛如松涛阵阵袭来，让人无处可逃",
               :damage =>20
               #:damage_type=>""
               
           }
          ]
   end

end