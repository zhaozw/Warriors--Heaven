
module Game

class Skill
    
   # set activerecord object as skill data
   def set_data(skill)
       @skill = skill
   end 
   
   def data
       return @skill
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
           p "===>return #{@skill[:skills].inspect}"
            return @skill.to_json(*opt)
        else
            p "==>return {}"
            return "{}"
        end
   end
   
   def mengpai
       ""
   end

   def power(context)
     # context[:user].ext[:str] * @skill[:level]
    # damage(context)
      p = @skill[:level] * @skill[:level]  * @skill[:level] /3 
      str  = context[:user].tmp[:str]
      return  (p + context[:user].tmp[:str]+1) / 30 *      (( str+1)/10)
   end
    
   def damage(context)
       userext = context[:user].ext
       thisskill =  @skill
       
       d = thisskill[:level] * userext[:str] + userext[:str]
      
   end
    
 def speed(context)
       thisskill = @skill
       thisskill[:level] * 2 + context[:user].tmp[:dext].to_i
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
    
    def image
       "other/zhujian.png"
   end

   def action_msg(action)
        a = action
        return "【<span style='color:#ffaaaa'>#{dname}</span> 第#{a[:index]}式】#{a[:action]}" 
   end


   
end
end

