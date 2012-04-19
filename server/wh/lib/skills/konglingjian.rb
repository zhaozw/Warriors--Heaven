require 'skills/skill.rb'
class Konglingjian < Game::Skill 
#基本剑法
   def for
       return "attack sword"
   end
     def category
       "common"
   end
   def type 
       return "sword"
   end
   
   def dname
       "空灵剑"
   end
   
   def desc
       "崆峒派传世武功，后来明教金毛狮王谢逊夺得《七伤拳谱》 古抄本，终于练成。此拳法出拳时声势煊赫，一拳中有七股不同的劲力，或刚猛、或阴柔、或刚中有柔，或柔中有刚，或横出，或直送，或内缩，敌人抵挡不住这源源而来的劲力，便会深受内伤。谢逊曾以此拳击毙少林神僧空见大师。但这七伤拳倘由内力未臻化境的人来练，对自己便有极大伤害。人体内有阴阳二气、金木水火土五行，一练七伤，七者皆伤。所以所谓“七伤”，乃是先伤己，再伤人。"
   end
   
   def needResearchPoint
       100
   end
   
   def researchConditionDesc
       "基本拳脚>10级"
   end
   
   def mengpai
       "kongtong" # 崆峒派
   end
   
   
   def checkResearchCondition(context)
       user = context[:user]
       skill = user.query_skill("unarmed")
      
       if (!skill or skill.data[:level] <=10 )
           context[:msg] += "你的基本拳脚功夫还不够，无法参悟书中奥义"
           return false
       end
       return true
   end
   

  
   def damage(context)   # only for calculation, "render" function will make real damage
       user = context[:user]
       a = getAction
       d = a[:damage] + user.tmp[:str]
      
   end
    

  
   def defense(context)
       thisskill = @skill
       return thisskill[:level]
   end

   def attack_actions
       [
           {
               :level=>0,
               :action =>"$N一拳挥向$n的左脸",
               :damage => 10
               #:damage_type=>""
           },
           {
               :level=>10,
               :action =>"$N一拳挥向$n的右脸",
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
        if !context[:msg] 
            context[:msg]  = ""
        end
        context[:msg] += action_msg(a)
   end

end