
require 'skills/skill.rb'
class Jiuguishengzhuan < Game::Skill 

   def for
       return "attack unarmed"
   end
    
   def category
       "common"
   end
   def type 
       return "blade"
   end
   
   def dname
       "九鬼神伝流"
   end
   
   def desc
       "长平家的一刀流"
   end
    
   def needResearchPoint
       100
   end
   
   def researchConditionDesc
       "基本拳脚>10级"
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
   def damage(context)
       userext = context[:user].ext
       thisskill =  @skill
       
       d = thisskill[:level] * userext[:str] + userext[:str]
      
   end
    
   def speed(context)
       thisskill =  @skill
       thisskill[:level] * 2
   end

end