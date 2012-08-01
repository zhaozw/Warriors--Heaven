require 'skills/unarmed.rb'
class Chilianshenzhang < Unarmed 
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
       "赤練神掌"
   end
   
   def desc
      "传说中女魔头李莫愁的成名武功，掌中带毒，令江湖人士闻风丧胆。"
  end
   
   def needResearchPoint
       100
   end
   
   def researchConditionDesc
       "基本拳脚>10级"
   end
   
   def mengpai
       "五毒教" # 崆峒派
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
   

=begin  
   def damage(context)   # only for calculation, "render" function will make real damage
       user = context[:user]
       a = getAction
       d = a[:damage] + user.tmp[:str]
      
   end
    

  
   def defense(context)
       thisskill = @skill
       return thisskill[:level]
   end
=end
   def attack_actions
       [
           {
               :level=>0,
               :name=>"",
               :action =>"$Nが両手を裏返しにして、浅い青い光で$nをアタックした。",
               :damage => 10
               #:damage_type=>""
           },
           {
               # :level=>10,
               :level=>5,
               :name=>"",
               :action =>"$Nは左手が形するだけで、右手が毒ヘビのようにストレートに$nの胸をアタックした。",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>20,
               :level=>10,
               :name=>"",
               :action =>"$Nが両手を裏返しにして、体の周辺に暗い霧と一緒に、$nをアタックした。",
               :damage =>20,
               #:damage_type=>""
               
           },
           {
               # :level=>30,
               :level=>20,
               :name=>"",
               :action =>"$Nは両手を分けて、左手がさそりのようで、右手がへびのようで、同時に$nをアタックした。",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>50,
               :level=>30,
               :name=>"",
               :action =>"$Nが静かに内力を使い、両手が急に暗くなり、寒い風と一緒に$nの全身をアタックした。",
               :damage =>20
               #:damage_type=>""
               
           },
=begin
           {
               # :level=>80,
               :level=>50,
               :name=>"意惚恍",
               :action =>"$N凝神定气，使出七伤拳总诀中的「意恍惚诀」，向$n送出一股横出之力！",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>120,
               :level=>80,
               :name=>"魄飞扬",
               :action =>"$N你大喝一声，须发俱张，使出「七伤总诀」中的最后一诀【魄飞扬】，左右双拳连续击出，威猛无俦，打向$n！",
               :damage =>20
               #:damage_type=>""
               
           }
=end
          ]
   end
=begin
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
=end
end