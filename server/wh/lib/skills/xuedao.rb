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
               :name=>"磨歯吮血",
               :action =>"$Nが「磨歯吮血」を使い、刀を口に噛んで、$nの周辺でぐるぐる回って、ばきゃくを見付かり、急に前に進み、刀を取り、ストレートに切った。",
               :damage => 10
               #:damage_type=>""
           },
           {
               # :level=>10,
               :level=>5,
               :name=>"批紙削腐",
               :action =>"$Nが腰で力を使い、前に一歩半進み、急に足を戻り、しゃがむして$nの下に2回切った。即ち「批紙削腐」という。",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>20,
               :level=>10,
               :name=>"流星経天",
               :action =>"$Nが手を上げ、「流星経天」を使い、手の中の刀が飛び出して、光と一緒に、$nの$lへ行った。,
               :damage =>20,
               #:damage_type=>""
               
           },
           {
               # :level=>30,
               :level=>20,
               :name=>"血跡万里",
               :action =>"$Nが「血跡万里」を使い、もとの場所で回り、手を背の後ろに回し、$nの$lに刺さった。",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>50,
               :level=>30,
               :name=>"偸天換日",
               :action =>"$Nは両手反対で刀の先端を握り、体の前に合わせて、急に左肩が少し沈んで、「偸天換日」を使い、左手が右腕の下から出て、$nの視線を移させ、右手から刀で$nの$lを強く刺した。",
               :damage =>20
               #:damage_type=>""
               
           },

           {
               # :level=>80,
               :level=>50,
               :name=>"血洗天河",
               :action =>"$Nは急に刀を鞘に収め、相手に近づき、半部跪き、手を背の後ろに回し、「血洗天河」を使い、刀の光が$nの下から頭蓋骨まで行った。",
               :damage =>20
               #:damage_type=>""
               
           },
           {
               # :level=>120,
               :level=>80,
               :name=>"血流漫面",
               :action =>"$Nは「血流漫面」を使い、刀の光が風と一緒に、$nの顔に向いて切った。",
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