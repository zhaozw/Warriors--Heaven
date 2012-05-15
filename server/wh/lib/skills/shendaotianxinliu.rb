require 'skills/skill.rb'
class Shendaotianxinliu < Game::Skill 
#基本剑法
   def for
       return "attack unarmed"
   end
     def category
       "common"
   end
   def type 
       return "unarmed"
   end
   
   def dname
       "神道天心流"
   end
   
   def desc
       ""
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
   

  
   # def damage(context)   # only for calculation, "render" function will make real damage
   #     user = context[:user]
   #     a = getAction
   #     d = a[:damage] + user.tmp[:str]
   #    
   # end
   #  

  
   def defense(context)
       thisskill = @skill
       return thisskill[:level]
   end

   def attack_actions # from pishi-poyu quan
       [
           {
               :level=>0,
               :name=>"花弁手",
               :action =>"身子微躬、右拳左掌合着一揖，突然随势向前疾探，打向$n$l",
               :damage => 10,
               #:damage_type=>""
           },
           {
               :level=>10,
               :name=>"浮　葉",
               :action =>"$N左掌虚抚，右拳“嗖”地一声从掌风中猛穿出来，击向$n的$l",
               :damage =>20,
               #:damage_type=>""
               
           },
           {
               :level=>20,
               :name=>"風揺枝",
               :action =>"$N右拳使出七伤拳总诀中的「摧肝肠诀」，双拳刚中有柔，向$n击去",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               :level=>30,
               :name=>"桐之葉",
               :action =>"$N凝神定气，使出七伤拳总诀中的「藏离诀」，双拳柔中有刚，打出一股内缩之力！向$n击去",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               :level=>50,
               :name=>"龍　 風",
               :action =>"$N凝神定气，使出七伤拳总诀中的「精失诀」，双拳势如雷霆，将力道直向$n送去",
               :damage =>20,
               #:damage_type=>""
               
           },
           {
               :level=>70,
               :name=>"万 雷",
               :action =>"$N凝神定气，使出七伤拳总诀中的「意恍惚诀」，向$n送出一股横出之力！",
               :damage =>20,
               #:damage_type=>""
               
           },
           {
               :level=>90,
               :name=>"片　 雲",
               :action =>"$N你大喝一声，须发俱张，使出「七伤总诀」中的最后一诀【魄飞扬】，左右双拳连续击出，威猛无俦，打向$n！",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               :level=>120,
               :name=>"燕　返",
               :action =>"$N你大喝一声，须发俱张，使出「七伤总诀」中的最后一诀【魄飞扬】，左右双拳连续击出，威猛无俦，打向$n！",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               :level=>150,
               :name=>"七里引",
               :action =>"$N你大喝一声，须发俱张，使出「七伤总诀」中的最后一诀【魄飞扬】，左右双拳连续击出，威猛无俦，打向$n！",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               :level=>180,
               :name=>"雪　崩",
               :action =>"$N你大喝一声，须发俱张，使出「七伤总诀」中的最后一诀【魄飞扬】，左右双拳连续击出，威猛无俦，打向$n！",
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
   

    
   # def doDamage(context)
   #      # damage
   #      d = damage(context)                
   #   #   context[:target].set_temp("hp", context[:target].query_temp("hp")-d)
   #      context[:target].tmp[:hp] -= d
   #      # cost stamina
   #      cs = cost_stam(context)
   #      #context[:user].set_temp("stam", context[:user].query_temp("stam") - cs)
   #      context[:user].tmp[:stam] -= cs
   #      context[:msg] = damage_msg(d, type) + "(体力-#{cs})"
   # end
   
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