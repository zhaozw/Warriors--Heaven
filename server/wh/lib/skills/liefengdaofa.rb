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
               :action =>"$N大喝一声，手中$w大开大阖，连连挥刀使出「呵壁问天」，斩向$n的$l",
               :damage => 10
               #:damage_type=>""
           },
           {
               :level=>10,
               :name=>"气盖河山",
               :action =>"$N运刀如风，一招「气盖河山」，刀势霸道之极，向着$n周身各处猛砍猛劈",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               :level=>20,
               :name=>"天地乍合",
               :action =>"$N一着「天地乍合」，突然抢进$n近侧，迅猛地驱刀连斩，攻式顿然合成一个圆圈",
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