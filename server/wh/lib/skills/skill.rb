
module Game

class Skill
    
    def initialize
        @skill = {
            :category => category,
            :dname => dname,
            :image=>image
        }
        p "==>skill initialized, #{@skill.inspect}" 
    end
   # set activerecord object as skill data
   def set_data(skill)
       p "==>set data1 , #{skill.inspect}" 
       @skill.each{|k,v|
           p "=>add #{k}=#{v}"
        skill[k.to_sym] =v
       }
       @skill = skill
       p "==>set data , #{@skill.inspect}" 
   end 
   
   def data
       return @skill
   end 
   
   def set(n,v)
       @skill[n.to_sym] = v
   end
   def query_data(n)
       return data[n]
   end
   
   def query(m, p)
       _m = self.method(m)
       _m.call(p)
   end
   
   def []name
       data[name]
   end
   
   def to_json(*opt)
     p "skill to json"
    #   return "{}"
       if (data)
           # p "===>return #{@skill.inspect}"
            return @skill.to_json(*opt)
        else
            # p "==>return {}"
            return "{}"
        end
   end
   
   def mengpai
       ""
   end

   # def power(context)
   #   # context[:user].ext[:str] * @skill[:level]
   #  # damage(context)
   #    p = @skill[:level] * @skill[:level]  * @skill[:level] /3 
   #    str  = context[:user].tmp[:str]
   #    return  (p + context[:user].tmp[:str]+1) / 30 *      (( str+1)/10)
   # end
    
   # def damage(context)
   #     userext = context[:user].tmp
   #     thisskill =  @skill
   #     
   #     d = thisskill[:level] * userext[:str] + userext[:str]
   #    
   # end
    
 def speed(context)
       thisskill = @skill
       thisskill[:level] * 2 + context[:user].tmp[:dext].to_i
   end

   # def damage_msg(d, weapon_type)
   #      if d == 0
   #          return "结果没有对$n造成任何伤害"
   #      end
   #      msg = ""
   #      p "==>weapon type #{weapon_type}"
   #      case weapon_type
   #      when "unarmed"
   #          if (d < 10)
   #              return "只把$n打的退了半步，毫发无损!"
   #          elsif (d < 20)
   #              return "[砰]的一声把$n击退了好几步，差点摔倒!"
   #          elsif (d < 20)  
   #              return "结果一击命中，$n闷哼了一声显然吃了不小的亏!"
   #          elsif (d < 50)
   #              return "重重的击中了$n, $n【哇】的吐出了一口鲜血!"
   #          else
   #              return "只听见【砰】的一声巨响，$n象稻草般的飞了出去!"   
   #          end
   #      else
   #          return "对$n造成<span class='damage'>#{d}</span>点伤害"
   #      end
   #      msg += "(Hp-<span class='damage'>#{d}</span>)"
   #      return msg
   #  end
   #  
    def image
       "other/zhujian.png"
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
   
   
   # def damage(context)   # only for calculation, "render" function will make real damage
   #     user = context[:user]
   #     a = getAttackAction
   #     d = a[:damage] + user.tmp[:str]
   # end
    
  def getAttackAction
      level = @skill[:level]
      actions = attack_actions
      i = 0;
      ar = []
      for a in actions    
         if (a[:level] > level)
             break
         end
         ar.push(a)
         i += 1
      end
      r = 0
      if ar.size > 1
        max=ar.size-1
        r = (rand(max*2)+rand(max*2))/2
        r = max if r > max
      end
      actions[r][:index] = r  #第几式
      a = actions[r]
   end

   # def getAttackActionMsg(context)
   #     a = getAttackAction
   #      # target = context[:target]
   #      p "action=#{a}"
   # 
   #      
   #      
   #      # generate msg
   #      #context[:msg] += translate_msg(a[:action], context)
   # 
   #      context[:msg] += action_msg(a)
   # end


   	def hit(context)
    end
end
end

