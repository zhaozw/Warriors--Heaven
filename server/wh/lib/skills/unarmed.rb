#require 'utility.rb'
require 'skills/skill.rb'

class Unarmed < Skill
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
     "基本拳脚"
   end

   def damage(context)   # only for calculation, "render" function will make real damage
       user = context[:user]
       a = getAction
       d = a[:damage] + user.tmp[:str]
      
   end
    
   def power(context)
     # context[:user].ext[:str] * @skill[:level]
    # damage(context)
      p = @skill[:level] * @skill[:level]  * @skill[:level] /3 
      str  = context[:user].tmp[:str]
      return  (p + context[:user].tmp[:str]+1) / 30 *      (( str+1)/10)
   end
    
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
   
      def damage_msg(d, weapon_type)
        if d == 0
            return "结果没有对$n造成任何伤害"
        end
        p "==>weapon type #{weapon_type}"
        case weapon_type
        when "unarmed"
            if (d < 10)
                return "只把$n打的退了半步，毫发无损!(Hp-#{d})"
            elsif (d < 20)
                return "[砰]的一声把$n击退了好几步，差点摔倒!(Hp-#{d})"
            elsif (d < 20)
                return "结果一击命中，$n闷哼了一声显然吃了不小的亏!(Hp-#{d})"
            elsif (d < 50)
                return "重重的击中了$n, $n【哇】的吐出了一口鲜血!(Hp-#{d})"
            else
                return "只听见【砰】的一声巨响，$n象稻草般的飞了出去!(Hp-#{d})"   
            end
        else
            return "对$n造成#{d}点伤害"
        end
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
        context[:msg] += "【#{dname} 第#{a[:index]}式】#{a[:action]}" 
   end

end
