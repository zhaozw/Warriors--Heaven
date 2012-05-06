
def damage_msg1( damage,  type)

	 str="";
	return "造成 " + damage + " 点" + type + "。\n";
=begin
	if( damage == 0 ) return "结果没有造成任何伤害。\n";

	switch( type ) {
	case "擦伤":
	case "割伤":
		if( damage < 10 ) return "结果只是轻轻地划破$p的皮肉。\n";
		elseif( damage < 20 ) return "结果在$p$l划出一道细长血痕。\n";
		elseif( damage < 40 ) return "结果「嗤」一声划出一道伤口！\n";
		elseif( damage < 80 ) return "结果「嗤」地一声划出一道血淋淋的伤口！\n";
		elseif( damage < 160 ) return "结果「嗤」地一声划出一道又长又深的伤口，溅得$N满脸鲜血！\n";
		else return "结果只听见$n一声惨嚎，$w已在$p$l划出一道深及见骨的可怕伤口！！\n";
	    end
		break;
	case "刺伤":
		if( damage < 10 ) return "结果只是轻轻地刺破$p的皮肉。\n";
		elseif( damage < 20 ) return "结果在$p$l刺出一个创口。\n";
		elseif( damage < 40 ) return "结果「噗」地一声刺入了$n$l寸许！\n";
		elseif( damage < 80 ) return "结果「噗」地一声刺进$n的$l，使$p不由自主地退了几步！\n";
		elseif( damage < 160 ) return "结果「噗嗤」地一声，$w已在$p$l刺出一个血肉□糊的血窟窿！\n";
		else return "结果只听见$n一声惨嚎，$w已在$p的$l对穿而出，鲜血溅得满地！！\n";
		break;
	case "瘀伤":
		if( damage < 10 ) return "结果只是轻轻地碰到，比拍苍蝇稍微重了点。\n";
		elseif( damage < 20 ) return "结果在$p的$l造成一处瘀青。\n";
		elseif( damage < 40 ) return "结果一击命中，$n的$l登时肿了一块老高！\n";
		elseif( damage < 80 ) return "结果一击命中，$n闷哼了一声显然吃了不小的亏！\n";
		elseif( damage < 120 ) return "结果「砰」地一声，$n退了两步！\n";
		elseif( damage < 160 ) return "结果这一下「砰」地一声打得$n连退了好几步，差一点摔倒！\n";
		elseif( damage < 240 ) return "结果重重地击中，$n「哇」地一声吐出一口鲜血！\n";
		else return "结果只听见「砰」地一声巨响，$n像一捆稻草般飞了出去！！\n";
	    end
		break;
	case "内伤":
		if( damage < 10 ) return "结果只是把$n打得退了半步，毫发无损。\n";
		elseif( damage < 20 ) return "结果$n痛哼一声，在$p的$l造成一处瘀伤。\n";
		elseif( damage < 40 ) return "结果一击命中，把$n打得痛得弯下腰去！\n";
		elseif( damage < 80 ) return "结果$n闷哼了一声，脸上一阵青一阵白，显然受了点内伤！\n";
		elseif( damage < 120 ) return "结果$n脸色一下变得惨白，昏昏沉沉接连退了好几步！\n";
		elseif( damage < 160 ) return "结果重重地击中，$n「哇」地一声吐出一口鲜血！\n";
		elseif( damage < 240 ) return "结果「轰」地一声，$n全身气血倒流，口中鲜血狂喷而出！\n";
		else return "结果只听见几声喀喀轻响，$n一声惨叫，像滩软泥般塌了下去！！\n";
		end
		break;
	default:
		if( !type ) type = "伤害";
		if( damage < 10 ) str =  "结果只是勉强造成一处轻微";
		elseif( damage < 20 ) str = "结果造成轻微的";
		elseif( damage < 30 ) str = "结果造成一处";
		elseif( damage < 50 ) str = "结果造成一处严重";
		elseif( damage < 80 ) str = "结果造成颇为严重的";
		elseif( damage < 120 ) str = "结果造成相当严重的";
		elseif( damage < 170 ) str = "结果造成十分严重的";
		elseif( damage < 230 ) str = "结果造成极其严重的";
		else str =  "结果造成非常可怕的严重";
		end
		return str + type + "！\n";
	end
=end
end

    def chooseBestSkill(context, pur, weapon_type, prop)
            p "choose best skill for #{pur}/#{weapon_type} by #{prop}"
            # p "skills #{context[:skills]}(size=#{context[:skills].size})}"
            attacker_skills = context[:skills]
     
            best_skill = {
                :skill => nil
            }
            best_skill[prop] = 0
            reg2  = Regexp.new("#{pur}", true)
            if (weapon_type and weapon_type.length >0)
                reg = Regexp.new("#{weapon_type}", true)
            else
                reg = /./i
            end
            p "==>1#{attacker_skills.inspect}"
            for skill in attacker_skills
                if (!skill)
                    next
                end
                skillname = skill.query_data("skname")
                p "===>skill = #{skill}"
                p "===>skill name =#{skillname}"
                #context[:thisskill] = skill
#                purpose = query_skill(skillname, "for", skill, context)

                purpose = skill.for     # usage: attack parry ...
                type = skill.type       # skill type: unarmed, fencing, daofa...
                
                # if skill is for attacking and has correct type with weapon
                if type=~ reg and purpose=~reg2 
                 #   ret = query_skill(skillname, prop, skill, context)
                    # ret = skill.query(prop, context)
                    ret = skill_power(skill, context, pur)
                    p "===>#{prop} of #{skillname}: #{ret} \n"
                    if (ret.to_i > best_skill[prop])
                        best_skill[prop] = ret
                        best_skill[:skill] = skill
                    end
                end

                
                #p "target:"+@target_class+", cmd:"+@cmd+", param:"+@cparam
            end
            if ( best_skill[:skill] == nil)
                #if not found, add basic skill for this type of skill
                _skname = weapon_type
                if (pur == 'dodge')
                    _skname = 'dodge'
                elsif (pur == 'parry')
                    _skname = 'parry'
                end
                if _skname == nil or _skname==""
                    raise "skill name is nil"
                end
                 # us = Userskill.new({
                 #     :uid        =>  context[:user][:id],
                 #     :sid        =>  context[:user][:sid],
                 #     :skid       =>  0,
                 #     :skname     =>  _skname,
                 #     :skdname    =>  "basic #{weapon_type}",
                 #     :level      =>  0,
                 #     :tp         =>  0,
                 #     :enabled    =>  1   
                 # })
                 # us.save!
               us =  context[:user].set_skill(_skname, 0, 0)
                attacker_skills.push(us)
                best_skill[:skill] = us
            end
            p "==>best skill of #{context[:user][:user]} for #{pur}, skill_type #{weapon_type}: #{best_skill}"
            return best_skill
    end
    
    def choosBestAttackSkill(context, weapon_type)
            attack_skill = chooseBestSkill(context, "attack", weapon_type, "damage")
          #  context[:thisskill] = attack_skill[:skill]
          #  ret = query_skill(attack_skill[:skill][:skname], "speed", context)
          #  attack_skill["speed"] = ret
            # p "==> damage of #{attack_skill[:skill][:skname]}: #{attack_skill['damage']}"
            return attack_skill
    end
    
    def choosBestDodgeSkill(context)
        attack_skill = chooseBestSkill(context, "dodge", nil, "speed")
    
            # p "==>#{context[:user].ext[:name} speed of #{attack_skill[:skill][:skname]}: #{attack_skill['speed']}"
            return attack_skill
    end
    
    def choosBestDefenseSkill(context, weapon_type)
        attack_skill = chooseBestSkill(context, "parry", nil, "defense")
    
        # p "==> defense of #{attack_skill[:skill][:skname]}: #{attack_skill['defense']}"
        return attack_skill
    end
    
   #
   # $N=>attacker $n=>defenser
   # $l=>limb
   # $p=> defenesr的人称代词
   # $w => weapon
    def translate_msg(msg, context)
    
        attacker = context[:user]
      #  p attacker[:name] 
      #  p msg
        defenser = context[:target]
        
        limb = context[:limb]
        if !limb
           # srand(Time.now.tv_usec.to_i)
            n = rand(defenser.limbs.size).to_i
            p "===>n=#{n}"
            limb = defenser.limbs[n]
        end
        
        
      #  p "player uid #{attacker.tmp[:uid]}, your uid #{session[:uid]}, msg=#{msg}"
      weapon = "武器"
      if (attacker.query_all_weapons && attacker.query_all_weapons.size>0)
          weapon = attacker.query_all_weapons.values[0].dname
      end
      msg = msg.gsub(/\$l/, limb).gsub(/\$w/, weapon)
           if (attacker[:isUser])
                m = msg.gsub(/\$N/, "你").gsub(/\$n/, defenser.name).gsub(/\$p/, "他")
            else
                m = msg.gsub(/\$N/, "<span class='npc'>#{attacker.name}</span>").gsub(/\$n/, "你").gsub(/\$p/, "你")
            end
        p m
        return  m
    end
      
    #   def damage_msg(d, weapon_type)
    #     if d == 0
    #         return "结果没有对$n造成任何伤害"
    #     end
    #     p "==>weapon type #{weapon_type}"
    #     case weapon_type
    #     when "unarmed"
    #         if (d < 10)
    #             return "只把$n打的退了半步，毫发无损!(Hp-#{d})"
    #         elsif (d < 20)
    #             return "[砰]的一声把$n击退了好几步，差点摔倒!(Hp-#{d})"
    #         elsif (d < 20)
    #             return "结果一击命中，$n闷哼了一声显然吃了不小的亏!(Hp-#{d})"
    #         elsif (d < 50)
    #             return "重重的击中了$n, $n【哇】的吐出了一口鲜血!(Hp-#{d})"
    #         else
    #             return "只听见【砰】的一声巨响，$n象稻草般的飞了出去!(Hp-#{d})"   
    #         end
    #     else
    #         return "对$n造成#{d}点伤害"
    #     end
    # end
      def damage_msg(d, weapon_type)
        if d == 0
            return "结果没有对$n造成任何伤害"
        end
        # msg = ""
        p "==>weapon type #{weapon_type}"
        case weapon_type
        when "unarmed"
            if (d < 10)
                return "只把$n打的退了半步，毫发无损!"
            elsif (d < 20)
                return "[砰]的一声把$n击退了好几步，差点摔倒!"
            elsif (d < 20)  
                return "结果一击命中，$n闷哼了一声显然吃了不小的亏!"
            elsif (d < 50)
                return "重重的击中了$n, $n【哇】的吐出了一口鲜血!"
            else
                return "只听见【砰】的一声巨响，$n象稻草般的飞了出去!"   
            end
        when "fencing"        
	    	if ( d < 10 ) 
	    	    return "结果只是轻轻地划破$p的皮肉。"
    		elsif ( d < 20 ) 
    		    return "结果在$p$l划出一道细长血痕。"
    		elsif ( d < 40 ) 
    		    return "结果「嗤」一声划出一道伤口！"
    		elsif ( d < 80 ) 
    		    return "结果「嗤」地一声划出一道血淋淋的伤口！"
    		elsif ( d < 160 ) 
    		    return "结果「嗤」地一声划出一道又长又深的伤口，溅得$N满脸鲜血！"
    		else return "结果只听见$n一声惨嚎，$w已在$p$l划出一道深及见骨的可怕伤口！！"
    	    end
        else
            return "对$n造成<span class='damage'>#{d}</span>点伤害"
        end
   
        # return msg
    end
    
    #  translate arabic number to Chinse e.g.“第三十六式”
    def action_msg(skill, action)
        a = action
        return "【<span style='color:#ffaaaa'>#{skill.dname}</span> 第#{a[:index]}式】<br/>#{a[:action]}" 
    end
    
    def doDamage(attacker_attack_skill, context, ap)
        d = context[:damage]
        p1 = context[:user]
        p2 = context[:target]
        
      
        # apply damage from equipment and weapon or other things
        ad = p1.tmp[:apply_damage]
         # give some fuzzy
        if (ad > 0)
            ad = (ad + rand(ad)) / 2;
            d += ad
        end
        p "apply damage > #{d}"
        
        if d <= 30
            d = 30
        end
        
        d = d.to_f
       # p "fuzzy damage > #{d}"
    
        # apply skill damage
        skill = context[:user].query_skill(attacker_attack_skill[:skill][:skname])
        
        # apply damage of zhaoshi
        action = context[:action]
        if (action[:damage])
            d += action[:damage]/10 * (d / 30);
        end
        p "apply skill zhaoshi damage > #{d}"
    
        if d <= 10
            d = 10
        end
        # apply general damage of skill (equal skill, eqaul damage)
        d += (skill.data[:level]+ 1) /10 * (d /10);
        p "apply skill common damage > #{d}"
        
        damage_bonus = p1.tmp[:str]
        
        d += (damage_bonus + rand(damage_bonus))/2
        p "apply damage bonus > #{d}"
        
        # Let combat exp take effect
        defense_factor = calc_total_exp(p2.tmp[:level]);
        while( rand(defense_factor) > calc_total_exp(p1.tmp[:level])+1) 
                        d -= d / 3
                        defense_factor /= 2
        end
        p "apply exp > #{d}"
        
        # apply denfenser's armo defense
        d -= (rand(p2.tmp[:apply_defense]) + p2.tmp[:apply_defense])/2
        
        p "apply defenser's armo > #{d}"
        d = d.to_i
        # TODO Let special weapon take effect
        # TODO Let special armo take effect
        # TODO Let special dodge take effect
        
       # p "freturn skill #{skill}"
       # d = skill.damage(context)                
        #context[:target].tmp[:hp] -= d
        # p "===>1#{context[:user][:apply_damage].inspect}\r\n#{context[:target][[:apply_defense]].inspect}"
        # d += skill.damage(context) + context[:user].tmp[:apply_damage]/10 - context[:target].tmp[:apply_defense]/10
        p "===>damage=#{d}"
        d = 0 if d <0
        context[:target].tmp[:hp] -= d
         cs = cost_stam(ap)
        #context[:user].set_temp("stam", context[:user].query_temp("stam") - cs)
        context[:user].tmp[:stam] -= cs
        m = damage_msg(d, skill.type) + "(<span class='attr'>Hp</span>:<span class='damage'>-#{d}</span>)(<span class='attr'>体力</span>:<span class='damage'>-#{cs}</span>)"
        # m = skill.doDamage(context)
        return "<br/>\n"+translate_msg(m, context)
    end
    
    def cost_stam(power)
       # p ("power #{power(context)}")
       # p ("power^1/3 #{power(context)**(1.0/3.0)}")
       p = power**(1.0/3.0)
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
    def doParry(defenser_dense_skill, context, pp)
        skill = context[:user].query_skill(defenser_dense_skill[:skill][:skname])
        # skill.doParry(context)
        
        # cost stamina
        cs = cost_stam(pp)
        context[:user].tmp[:stam] -= cs
        context[:msg] += "结果被$N挡开"
        return "<br/>\n"+translate_msg(context[:msg], context)+"(<span class='attr'>体力</span><span class='damage'>-#{cs}</span>)"
    end
    

    #
    # Usage: 0: attack 1: defense(parry) 3:dodge
    #
    def skill_power(skillname, context, usage)
       skill =  context[:user].query_skill(skillname)
       if (skill == nil)
           #logger.info("user #{context[:user][:id]}-#{context[:user].ext[:name]} doesn't have skill '#{skillname}'")
           return 1
       end
       # p = skill.power(context)
        p = skill.data[:level] * skill.data[:level]  * skill.data[:level] /3 
        str  = context[:user].tmp[:str]
        dext = context[:user].tmp[:dext]
        p "===>#{context[:user].tmp.inspect}"
        
        if (usage == "attack")
            p =   (p + calc_total_exp(context[:user].tmp[:level]) +1) / 30 * (( str+1)/10)
        else
            p =   (p + calc_total_exp(context[:user].tmp[:level]) +1) / 30 * (( dext+1)/10)
        end
        
       if p <= 0
           return 1
       else
           return p
       end
    end
    
    # return true if level up, point can be 0
    def improve_skill(player, skillname, point)
        p  player.query_skill(skillname)
        skill = player.query_skill(skillname).data
        p "improve skill #{skill}#{skill.inspect}"
        skill[:tp] += point
        e = calc_total_exp(player.tmp[:level]) + player.tmp[:exp]
        if ( (skill[:level]+1)*(skill[:level]+1) <= skill[:tp] )
            if (skill[:level] +1) * (skill[:level] +1) *(skill[:level] +1)/10>e
            #    error "You need more battle experience"
             #   return
            else
                skill[:level] += 1
                skill[:tp] = 0
                return true
            end
        end
        # save to db after fight finished
        return false
    end
    def doDodge(skill, context, dp)
        srand Time.now.tv_usec.to_i
        a = skill.dodge_actions
    
        
        # cost stamina
             cs = cost_stam(dp)
        context[:user].tmp[:stam] -= cs
        
        context[:msg] += a[rand(a.length)] + "(<span class='attr'>体力</span><span class='damage'>-#{cs}</span>)"
        
    end
   def __fight(attacker, defenser)  # one round
        msg = ""
        
        context_a = {
                    :user => attacker,
                    :skills=> attacker.query_all_skills,
                    :target => defenser,
                    :gain => attacker[:gain],
                    :msg => ""
        }
        if (attacker.tmp[:stam] <= 0 )
            msg = translate_msg("$N的体力不够， 无法发起进攻", context_a)
            return msg
        end

                # do attack
                damage = 0
            context_d = {
                    :user => defenser,
                   # :thisskill => defenser[:dodge_skill][:skill],
                    :skills=>   defenser.query_all_skills,
                    :target => attacker,
                    :gain => defenser[:gain],
                    :msg => ""
            }
            # get attack action
            context_a[:action] = attacker[:attack_skill][:skill].getAttackAction
            # attacker[:attack_skill][:skill].getAttackActionMsg(context_a)
            
            
           # query_skill(attacker[:attack_skill][:skill][:skname], "doAttack", attackerattack_skill][:skill], context_a)
                
          #  dname = attacker.query_skill(attacker[:attack_skill][:skill][:skname]).dname
          #   msg += "<br/>\n【#{dname}】"+translate_msg(context_a[:msg], context_a)
               
               msg += "<br/>\n"+translate_msg(action_msg(attacker[:attack_skill][:skill], context_a[:action]), context_a)
              
             #
             # hit ?
             #
             
             p "attack skill #{attacker[:attack_skill][:skill][:skname]} level=#{attacker[:attack_skill][:skill][:level]}\n"
             p "dodage skill #{defenser[:dodge_skill][:skill][:skname]} level=#{defenser[:dodge_skill][:skill][:level]}\n"
    
           #  attack_speed = query_skill(attacker[:attack_skill][:skill][:skname], "power", attacker[:attack_skill][:skill], context_a)
                attack_power = skill_power(attacker[:attack_skill][:skill][:skname], context_a, "attack")
           #  defenser_speed = query_skill(defenser[:dodge_skill][:skill][:skname], "power", defenser[:dodge_skill][:skill], context_d)
              if (defenser.tmp[:stam]<=0)
                  dodge_power = 0
                  msg += "<br/>\n$n的体力不够，无法闪躲"
              else
                dodge_power = skill_power(defenser[:dodge_skill][:skill][:skname], context_d, "dodge") + defenser.tmp[:apply_dodge]/10
                end
             p "attack_power(#{attacker[:user]}) speed=#{attack_power}\n"
             p "defense_power(#{defenser[:user]}) speed=#{dodge_power}\n"
             msg += "dp:#{dodge_power} ap:#{attack_power}"
             if rand(attack_power+dodge_power) < dodge_power # miss
                 #
                 # attack missed
                 #
                 context_a[:msg] = "";
                 # defenser[:dodge_skill][:skill].doDodge(context_d)
                 doDodge(defenser[:dodge_skill][:skill], context_d, dodge_power)
               #  query_skill(defenser[:dodge_skill][:skill][:skname], "doDodge", defenser[:dodge_skill][:skill], context_d)
                 msg += "<br/>\n"+translate_msg(context_d[:msg], context_d)
                 
                 # improve dodge skill
                 if (rand(defenser.tmp[:it]+1) > 10)
                    
                    context_d[:gain][:exp] += 1
                    defenser.tmp[:exp] += 1
                    
                    context_d[:gain][:pot] += 1
                    defenser.tmp[:pot] += 1
                    
                    
                    gain_point = 1
                    context_d[:gain][:skills][defenser[:dodge_skill][:skill][:skname]][:point] += gain_point
                    if (defenser.isUser)
                        msg += "<div class='rgain'>"
                        msg += "<br/> 战斗经验+1 潜能+1 #{defenser.query_skill(defenser[:dodge_skill][:skill][:skname]).dname}+#{gain_point}"
                        if (improve_skill(defenser, defenser[:dodge_skill][:skill][:skname], gain_point) )
                             context_d[:gain][:skills][defenser[:dodge_skill][:skill][:skname]][:level] +=1
                             msg +="<br/> #{defenser[:dodge_skill][:skill].dname} level up !"
                         end
                         msg += "</div>"
                    end
                   
                 end
                 
                 damage += 1 #  result_dodge                         
                 
                 # TODO should lose energy and first-attackdefenser[:defense_skill]
             else
                 
                 # 
                 # hit, check parry
                 #
                 
                 #check whether parry take effect pow(parry)+pow(weapon)>=pow(attack)+pow(weapon)
       
                 # if (!defenser[:defense_skill]) # no parry
                 #    msg += doDamage(attacker[:attack_skill],context_a)
                 #    # gain exp and skill point
                 #    if ( rand(attacker.ext[:it]+1) > 10)        
                 #        context_a[:gain][:exp] += 1
                 #        attacker.tmp[:exp] += 1
                 #        context_a[:gain][:pot] += 1
                 #        attacker.tmp[:pot] += 1
                 #        gain_point = 1
                 #        context_a[:gain][:skills][attacker[:attack_skill][:skill][:skname]][:point] += gain_point
                 #        if attacker.isUser
                 #            msg += "<br/> 战斗经验+1 潜能+1 #{attack.query_skill(attacker[:attack_skill][:skill][:skname]).dname}+#{gain_point}"
                 #            if (improve_skill(attacker, attacker[:attack_skill][:skill][:skname], gain_point) )
                 #                 context_a[:gain][:skills][attacker[:attack_skill][:skill][:skname]][:level] +=1
                 #                msg +="<br/> #{attacker[:attack_skill][:skill][:skname]} level up !"
                 #             end
                 #         end
                 #    end
                 # else
                 
                 # check parry power
                 if (!defenser[:defense_skill])     
                     parry_power = 0 
                 else
                     # has parry skill
                     context_d[:thisskill] = defenser[:defense_skill][:skill]
               
                     if (defenser.tmp[:stam]<=0)
                         parry_power = 0
                         msg += "<br/>\n$n的体力不够，无法招架"
                     else
                         # if attacker has weapon but defenser hasn't, pp=0
                         if ((attacker.query_equipment("handright")||attacker.query_equipment("handleft")) && !(defenser.query_equipment("handright") || defenser.query_equipment("handleft")) )
                             parry_power = 0
                         else
                             # power_parry = defenser[:defense_skill][:skill].power(context_d)
                             parry_power = skill_power(defenser[:defense_skill][:skill][:skname], context_d, "parry")
                             # power_parry = query_skill(defenser[:defense_skill][:skill][:skname], "power", defenser[:defense_skill][:skill], context_d)
                         end
                     end
                     power_weapon_def = 0
                     # TODO get power of weapon
                     #  query_obj(objname, method, obj, context)
                     # power_attack = attacker[:attack_skill][:skill].power(context_d)
                     # power_attack = skill_power(attacker[:attack_skill][:skill][:skname], context_d, 0)
                     # power_attack = query_skill(attacker[:attack_skill][:skill][:skname], "power", attacker[:attack_skill][:skill], context_d)
                     # power_weapon_att = 0
                     # TODO get power of weapon
                     #  query_obj(objname, method, obj, context)

                     # p "power_parry=#{power_parry} + power_weapon_def=#{power_weapon_def}"
                     # p "power_attack=#{power_attack} + power_weapon_att=#{power_weapon_att}"
                     # if (power_attack == 0 )
                     #     power_attack = 1
                     # end
                     # if (power_parry==0 )
                     #     power_parry = 1
                     # end
                     # p "rand #{rand(power_parry + power_weapon_def + power_attack + power_weapon_att)}"
                     # p power_attack + power_weapon_att
                 end # has parry
                 
                 # 
                  msg += "pp:#{parry_power} ap:#{attack_power}"
                 if (rand(parry_power  + attack_power  ) >= attack_power ) # can parry
                     #
                     # parry succeeded
                     #
                     msg += doParry(defenser[:defense_skill], context_d, parry_power)
                     if (rand(defenser.tmp[:it]+1) > 10)
                         context_d[:gain][:exp] += 1
                         defenser.tmp[:exp] += 1
                         context_d[:gain][:pot] += 1
                         defenser.tmp[:pot] += 1
                         gain_point = 1
                         context_d[:gain][:skills][defenser[:defense_skill][:skill][:skname]][:point] += gain_point
                         msg += "<div class='rgain'>"
                         msg += "<br/> 战斗经验<span>+1</span> 潜能<span>+1</span> #{defenser.query_skill(defenser[:defense_skill][:skill][:skname]).dname}<span>+#{gain_point}</span>"
                         if (improve_skill(defenser, defenser[:defense_skill][:skill][:skname], gain_point) )
                             context_d[:gain][:skills][defenser[:defense_skill][:skill][:skname]][:level] +=1
                             msg +="<br/><span> #{defenser[:defense_skill][:skill][:skname]} level up !</span>"
                         end
                         msg += "</div>"
                    end   
                    damage += 2 # RESULT_PARRY
                else
                    #
                    # failed in parrying
                    #
                    # do damage
                    context_a[:damage] = damage
                    msg += doDamage(attacker[:attack_skill], context_a, attack_power)
                    if ( rand(attacker.tmp[:it]+1) > 10)
                        context_a[:gain][:exp] += 1
                        attacker.tmp[:exp] += 1
                        context_a[:gain][:pot] += 1
                        attacker.tmp[:pot] += 1
                        gain_point = 1
                        context_a[:gain][:skills][attacker[:attack_skill][:skill][:skname]][:point] += gain_point
                        if attacker.isUser
                            msg += "<div class='rgain'>"
                            msg += "<br/> 战斗经验<span>+1</span> 潜能<span>+1</span> #{attacker.query_skill(attacker[:attack_skill][:skill][:skname]).dname}<span>+#{gain_point}</span>"
                            if (improve_skill(attacker, attacker[:attack_skill][:skill][:skname], gain_point) )
                                context_a[:gain][:skills][attacker[:attack_skill][:skill][:skname]][:level] +=1
                                msg +="<br/> <span>#{attacker[:attack_skill][:skill][:skname]} level up !</span>"
                            end
                            msg += "</div>"
                        end
                    end
                end # failed in parrying
                
         
            end # hit, check parry
             
             # show status
             msg += '<div class="status">'
             msg += "<br/>\n#{attacker[:user]}  <span class='attr'>hp</span>:#{attacker.tmp[:hp]} <span class='attr'>体力</span>:#{attacker.tmp[:stam]}\n<br/>"
             msg += "#{defenser[:user]}  <span class='attr'>hp</span>:#{defenser.tmp[:hp]} <span class='attr'>体力</span>::#{defenser.tmp[:stam]}\n<br/>"
             msg += "</div>"
             
             translate_msg(msg, context_a)
    end
    
    # def calcPlayerLoad(p1)
    #     weight = 0
    # 
    #     all = p1.query_all_wearings
    #     all.each {|k,v|                  
    #      weight += v.weight
    #     }
    #     p "===>2.5 leave"
    #     return weight
    # end
    
    # def calcPlayerDamage(p1)
    #     damage = 0
    #     all = p1.query_all_wearings
    #     all.each {|k,v|                  
    #      damage += v.damage
    #     }
    #     return damage
    # end
    # def calcPlayerDefense(p1)
    #     defense = 0
    #     all = p1.query_all_wearings
    #     all.each {|k,v|                  
    #      defense += v.defense
    #     }
    #     return defense
    # end
    # p1,p2: Objects/Player
    # context = {:msg=>""}
    def _fight(p1, p2, context)
        msg = context[:msg]
        
    
    
        msg += "<div> 战斗开始!</div>"
     
        # calculate temporary fight prop
        # p1.tmp[:apply_damage] = p1.query_weapon_damage
        # p1.tmp[:apply_dodge]  = 0-p1.query_all_weight
        # p1.tmp[:apply_defense] = p1.query_armo_defense 
        
        p1.tmp[:apply_dodge] = 0-p1.query_all_weight/10
        p1.tmp[:apply_damage] = p1.query_weapon_damage/10
        p1.tmp[:apply_defense] = p1.query_armo_defense/10
        p "====>p1 load: #{p1.tmp[:apply_dodge]} damage:#{p1.tmp[:apply_damage]} defense:#{p1.tmp[:apply_defense]  }"
        p2.tmp[:apply_dodge] = 0-p2.query_all_weight/10
        p2.tmp[:apply_damage] = p2.query_weapon_damage/10
        p2.tmp[:apply_defense] = p2.query_armo_defense/10
        p "====>p2 load: #{p2.tmp[:apply_dodge]} damage:#{p2.tmp[:apply_damage]} defense:#{p2.tmp[:apply_defense]  }"
        
        # calculate who attach first  
        # TODO need improve
        if (p1.query_temp("dext")+p1.tmp[:apply_dodge] > p1.query_temp("dext")+p2.tmp[:apply_dodge])
            attacker = p1
            #attacker_gain = gain_p1
            defenser = p2
           # defenser_gain = gain_p2
        else
            attacker = p2
            #attacker_gain = gain_p2
            defenser = p1
            #defenser_gain = gain_p1
        end
        
        p "attacker is #{attacker.name}"
        msg += "<div>#{attacker.name}抢先发动进攻!</div>"
        
        
        # what weapon attacker is wielding
        hand_right_weapon =  p1.query_equipment("handright")
        hand_left_weapon = p1.query_equipment("handleft")
        p "=>righthand weapons #{hand_right_weapon}"
        p "=>lefthand weapons #{hand_left_weapon}"
        # defaut is unarmed
        weapon_skill_type = 'unarmed'
        if (hand_right_weapon)
            weapon_skill_type = hand_right_weapon.skill_type
        elsif hand_left_weapon
            weapon_skill_type = hand_left_weapon.skill_type
        end
        
=begin
        reg = /unarmed/i
        if (hand_right_weapon)
            weapon_type = hand_right_weapon.type
            reg = Regexp.new("#{weapon_type}", true)
        end
=end        
        context_p1 = {
                    :user => p1,
                    :thisskill => nil,
                    :skills=>p1.query_all_skills,
                    :target => p2
        }
        # attacker choose the best dodge skill
        p1[:dodge_skill] = choosBestDodgeSkill(context_p1)
        # attacker choose the skill have best damage
        p1[:attack_skill] = choosBestAttackSkill(context_p1, weapon_skill_type)
        # attacker choose best defense skill
        p1[:defense_skill] = choosBestDefenseSkill(context_p1, weapon_skill_type)
        
        # choose skills for deffenser
        hand_right_weapon =  p2.query_equipment("handright")
        hand_left_weapon = p2.query_equipment("handleft")
        p "=>#{defenser[:user]} righthand weapons #{hand_right_weapon}"
        p "=>#{defenser[:user]} lefthand weapons #{hand_left_weapon}"
        # defaut is unarmed
        weapon_skill_type = 'unarmed'
        if (hand_right_weapon)
            weapon_skill_type = hand_right_weapon.skill_type
        elsif hand_left_weapon
            weapon_skill_type = hand_left_weapon.skill_type
        end
        context_p2 = {
                    :user => p2,
                    :thisskill => nil,
                    :skills=>p2.query_all_skills,
                    :target => p1
        }
        # defenser choose the best dodge skill
        p2[:dodge_skill] = choosBestDodgeSkill(context_p2)
        # defenser choose the skill have best damage
        p2[:attack_skill] = choosBestAttackSkill(context_p2, weapon_skill_type)
        # defenser choose best defense skill
        p2[:defense_skill] = choosBestDefenseSkill(context_p2, weapon_skill_type)      
        
        
       
        gain_p1 = {
            :exp =>0,
           # :hp =>0,
           # :stam =>0,
            :pot => 0,
            :level =>0,
            :skills =>{
                p1[:dodge_skill][:skill][:skname] =>
                {
                    :skill => p1[:dodge_skill][:skill][:skname],
                    :point => 0,
                    :level => 0,
                    :dname =>p1[:dodge_skill][:skill].dname
                },
                p1[:attack_skill][:skill][:skname] =>
                {
                    :skill => p1[:attack_skill][:skill][:skname],
                    :point => 0,
                    :level => 0,
                    :dname =>p1[:attack_skill][:skill].dname
                },
                p1[:defense_skill][:skill][:skname]=>
                {
                    :skill => p1[:defense_skill][:skill][:skname],
                    :point => 0,
                    :level => 0,
                    :dname =>p1[:defense_skill][:skill].dname
                }
            }
        }
        gain_p2 = {
            :exp =>0,
           # :hp =>0,
           # :stam =>0,
            :pot => 0,
            :level =>0,
            :skills =>{
                p2[:dodge_skill][:skill][:skname] =>
                {
                    :skill => p2[:dodge_skill][:skill][:skname],
                    :point => 0,
                    :level => 0,
                    :dname =>p2[:dodge_skill][:skill].dname
                },
                p2[:attack_skill][:skill][:skname] =>
                {
                    :skill => p2[:attack_skill][:skill][:skname],
                    :point => 0,
                    :level => 0,
                    :dname =>p2[:attack_skill][:skill].dname
                },
                p2[:defense_skill][:skill][:skname]=>
                {
                    :skill => p2[:defense_skill][:skill][:skname],
                    :point => 0,
                    :level => 0,
                    :dname =>p2[:defense_skill][:skill].dname
                }
            }
        }
      p "==>gain.skill #{gain_p1.inspect}"
         p "==>gain.skill #{gain_p2.inspect}"
      #  context[:gain_p1] = gain_p1
       # context[:gain_p2] = gain_p2
        p1[:gain] = gain_p1
        p2[:gain] = gain_p2
        
        if (attacker == p1)
            attacker_gain = gain_p1
            defenser_gain = gain_p2
        else
            attacker_gain = gain_p2
            defenser_gain = gain_p1
        end
        
        

        
        srand(Time.now.tv_usec.to_i)
        i = 0
        style_c = "user"
       
   
        while (i < 100 ) # max 100 turn
            if  style_c == "user"
               style_c = "enemy"
            else
                style_c = "user"
            end
            
             msg += "<div class=\"#{style_c}\">\n#{__fight(attacker, defenser)}\n</div>\n";
            i = i+1
            
         
            
             if (defenser.tmp[:hp] <=0 )
                 msg += "<br/>#{defenser[:user]}战斗不能"
                 break;
             end
             
             # swap
             t = defenser
              defenser =  attacker
             attacker = t
             
      
      
        end  #while
        
        #
        # save to db # TODO should the enemy also save gain ?
        #
    
        if (attacker[:isUser])
          gain = attacker[:gain]
          player = attacker
        else
          gain = defenser[:gain]
          player = defenser
        end
        bChange = false
        p "===>gain1=#{gain.inspect}"
        if (gain[:exp] != 0 )
            if ( (player.ext[:level]+1)*(player.ext[:level]+1)*(player.ext[:level]+1)<= player.tmp[:exp])
                gain[:level] = 1
                player.ext[:level] += 1
                player.ext[:exp] = 0
            end
            player.ext[:exp] = player.tmp[:exp]
            p "===>33player ext saved #{player.ext.inspect}"
            bChange = true
        end
        
        if (gain[:pot] != 0 )
            player.ext[:pot] = player.tmp[:pot]
            bChange = true
        end
        
        if (player.tmp[:stam] != player.ext[:stam])
            player.ext[:stam]  = player.tmp[:stam]
            bChange = true
        end
        
        if (player.tmp[:hp] != player.ext[:hp])
            player.ext[:hp]  = player.tmp[:hp]
            bChange = true
        end
      #  if bChange
       #     player.ext.save!
      #  end
        
        gain[:skills].each {|k, v|
            p "=>skill #{k}, #{v[:point]}, #{v[:level]}"
            if v[:point] != 0 || v[:level] != 0
                skill = player.query_skill(k).data
                p skill.inspect
                skill.save!
                p "save skill #{player.name} #{skill}#{skill.inspect}"
            end
        }
        
        msg += "\n<div class='fight_result'><div class='win'>\n"
        if (attacker[:isUser])
            msg += "You(#{attacker[:user]}) Win !"
        else
            msg += "You(#{defenser[:user]}) Lose !"
        end
        p attacker.tmp
        msg += "(in #{i} rounds)</div>\n"
        msg += "</div>"
        context[:msg] = msg
        p context[:msg]
        # return attacker[:isUser]
        return attacker == p1
    end
    