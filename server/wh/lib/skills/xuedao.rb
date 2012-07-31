require 'skills/daofa.rb'
class Xuedao < Daofa
#基本剑法
   def for
       return "attack unarmed"
   end
     def category
       "common"
   end
   def type 
       return "daofa"
   end
   
   def dname
       "血刀"
   end
   
   def desc
      "武林第一邪派高手「血刀老祖」的独门武功，配合传说的血刀门的宝物【血刀】威力巨大。"
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
               :name=>"磨牙吮血",
               :action =>"$N使出一招「磨牙吮血」，把刀咬在口中，只在$n身前身后乱转，瞅个破绽，猛地欺身向前，拔出刀来一刀直劈下去",
               :damage => 10
               #:damage_type=>""
           },
           {
               # :level=>10,
               :level=>5,
               :name=>"批纸削腐",
               :action =>"$N腰劲运肩，肩通於臂，向前一冲，跨出一步半，攸忽缩脚，身形一矮向$n下三路实砍两刀，正是一招「批纸削腐」",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>20,
               :level=>10,
               :name=>"流星经天",
               :action =>"$N手一扬，一招「流星经天」，手中刀脱手飞出，一溜红光，径向$n的$l飞去",
               :damage =>20,
               #:damage_type=>""
               
           },
           {
               # :level=>30,
               :level=>20,
               :name=>"血踪万里",
               :action =>"$N一招「血踪万里」，身子原地打了一个转, 反手一刀向$n的$l捅了过去",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>50,
               :level=>30,
               :name=>"偷云换日",
               :action =>"$N双手反执刀尖，合於怀中，突然左肩微沉，一招「偷云换日」，左手从右臂下穿出转移$n的目光，右手执刀猛刺$n的$l",
               :damage =>20
               #:damage_type=>""
               
           },

           {
               # :level=>80,
               :level=>50,
               :name=>"血洗天河",
               :action =>"$N突然还刀入鞘，蓦地欺近身去，身体半跪，反手抽刀，一式「血洗天河」，只见一片匹练也似的刀光从$n下阴直撩至天灵盖",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>120,
               :level=>80,
               :name=>"血流漫面",
               :action =>"$N刀尖平指，一招「血流漫面」，刀光霍霍，三横两直，带着阵阵风声砍向$n的面门",
               :damage =>20
               #:damage_type=>""
               
           }

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