require 'json'

class WhController < ApplicationController
    
    def index
        p "cookie=#{cookies}"
       # session[:name]="ju"
    #    ret = {
     #       "uid" => "ju"
      #  }


      
      sid = cookies[:_wh_session]
      
      # for test
      if (params[:sid])
          sid = params[:sid]
      end
        user = User.find_by_sql("select id, user, sid, sex, race, age, title from users where sid='#{sid}'")
   #     r = User.find_by_sql("select user, uid, sid, sex, race, age from users where sid='d434740f4ff4a5e758d4f340d7a5f467'")
        
        p sid
        if (user == 0 || user.size==0)
        #js = '{"error":"user not found"}'
            error "user not found"
            return
        end
        
        if (user.size >0)
            ret = Userskill.find_by_sql("select * from userskills where sid='#{sid}'")
            for rr in ret
                 s = load_skill(rr[:skname])
                 rr[:dname] = s.dname
                 rr[:category] = s.category
             end
            user[0][:userskills] = ret 
      
            session[:uid] = user[0][:id]
        end
        
        r = Userext.find_by_sql("select * from userexts where sid='#{sid}'")
        if (r.size>0)
            user[0][:userext] = r[0]
            session[:userdata] = user[0]
        end
        render :text=>user[0].to_json
    end
    
    
    def userext
        sid = cookies[:_wh_session]
        if !sid
            error("session not exist")
            return
        end
        
        r = Userext.find_by_sql("select uid, hp, maxhp, gold, exp, level, prop, sid from userexts where sid='#{sid}'")
         if (r.size >0)
            js = r[0].to_json
        else
            error("user not found")
            return
        end
        render :text=>js
    end
    
    def listPlayerToFight
       sid = cookies[:_wh_session]
       pagesize = params[:pagesize] || 10
       start = params[:start] || 0
       if !sid
            error("session not exist")
            return
        end
       r = Userext.find_by_sql("select uid, name, hp, maxhp, gold, exp, level, prop, sid, fame, race, dext, str, luck from userexts where sid<>'#{sid}' limit #{start}, #{pagesize}")
       if (r.size >0)
            js = r.to_json
        else
            error("record not found")
            return
        end
        render :text=>js
        
    end
    
 
    
    def chooseBestSkill(context, pur, weapon_type, prop)
            p "choose best skill for #{pur}/#{weapon_type} by #{prop}"
            p "skills #{context[:skills]}(size=#{context[:skills].size})}"
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
            for skill in attacker_skills
                if (!skill)
                    next
                end
                skillname = skill[:skname]
                p "===>skill = #{skill}"
                p "===>skill name =#{skillname}"
                #context[:thisskill] = skill
                purpose = query_skill(skillname, "for", skill, context)
                type = query_skill(skillname, "type", skill, context)
                
                # if skill is for attacking and has correct type with weapon
                if type=~ reg and purpose=~reg2 
                    ret = query_skill(skillname, prop, skill, context)
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
                 us = Userskill.new({
                    :uid        =>  context[:user][:id],
                    :sid        =>  context[:user][:sid],
                    :skid       =>  0,
                    :skname     =>  _skname,
                    :skdname    =>  "basic #{weapon_type}",
                    :level      =>  0,
                    :tp         =>  0,
                    :enabled    =>  1   
                })
                us.save!
                attacker_skills.push(us)
                best_skill[:skill] = us
            end
            return best_skill
    end
    
    def choosBestAttackSkill(context, weapon_type)
            attack_skill = chooseBestSkill(context, "attack", weapon_type, "damage")
          #  context[:thisskill] = attack_skill[:skill]
          #  ret = query_skill(attack_skill[:skill][:skname], "speed", context)
          #  attack_skill["speed"] = ret
            p "==> damage of #{attack_skill[:skill][:skname]}: #{attack_skill['damage']}"
            return attack_skill
    end
    
    def choosBestDodgeSkill(context)
        attack_skill = chooseBestSkill(context, "dodge", nil, "speed")
    
            p "==>#{context[:user].ext[:name]} speed of #{attack_skill[:skill][:skname]}: #{attack_skill['speed']}"
            return attack_skill
    end
    
    def choosBestDefenseSkill(context, weapon_type)
        attack_skill = chooseBestSkill(context, "parry", nil, "defense")
    
        p "==> defense of #{attack_skill[:skill][:skname]}: #{attack_skill['defense']}"
        return attack_skill
    end
    
    
    def render_skill (context)
        
    end
    
    # $N=>attacker $n=>defenser
    def translate_msg(msg, context)
        attacker = context[:user]
      #  p attacker[:name] 
      #  p msg
        defenser = context[:target]
        p "player uid #{attacker.ext[:uid]}, your uid #{session[:uid]}, msg=#{msg}"
           if (attacker.ext[:uid] == session[:uid])
                m = msg.gsub(/\$N/, "你").gsub(/\$n/, defenser.ext[:name])
            else
                m = msg.gsub(/\$N/, attacker.ext[:name]).gsub(/\$n/, "你")
            end
    end
    
    def damage_msg(d, weapon_type)
        if d == 0
            return "结果没有对$n造成任何伤害"
        end
        case weapon_type
        when "unarmed"
            if (d < 10)
                return "把$N打的退了半步，毫发无损!(Hp-#{d})"
            elsif (d < 20)
                return "[砰]的一声把N$N击退了好几步，差点摔倒!(Hp-#{d})"
            elsif (d < 20)
                return "结果一击命中，$N闷哼了一声显然吃了不小的亏!(Hp-#{d})"
            elsif (d < 50)
                return "重重的击中了, $N【哇】的吐出了一口鲜血!(Hp-#{d})"
            else
                return "只听见【砰】的一声巨响，$n象稻草般的飞了出去!(Hp-#{d})"
  
                
            end
        else
        end
    end
    
    def doDamage(attacker_attack_skill, context)
        skill = context[:user].query_skill(attacker_attack_skill[:skill][:skname])
       # p "freturn skill #{skill}"
       # d = skill.damage(context)                
        #context[:target].tmp[:hp] -= d

        m = skill.doDamage(context)
        return "<br/>\n"+translate_msg(m, context)
    end
    
    def doParry(defenser_dense_skill, context)
        skill = context[:user].query_skill(defenser_dense_skill[:skill][:skname])
        skill.doParry(context)
        return "<br/>\n"+translate_msg(context[:msg], context)
    end
    
    def skill_power(skillname, context)
       skill =  context[:user].query_skill(skillname)
       if (skill == nil)
           logger.info("user #{context[:user][:id]}-#{context[:user].ext[:name]} doesn't have skill '#{skillname}'")
           return 1
       end
       p = skill.power(context)
       if p <= 0
           return 1
       else
           return p
       end
    end
    
    # return true if level up
    def improve_skill(player, skillname, point)
        p  player.query_skill(skillname)
        skill = player.query_skill(skillname).data
        skill[:tp] += point
        if ( (skill[:level]+1)*(skill[:level]+1) <= skill[:tp] )
            skill[:level] += 1
            skill[:tp] = 0
            return true
        end
        # save to db after fight finished
        return false
    end
    def fight

        enemy_id= params[:enemy]
     #   r = Userext.find_by_sql("select uid, name, hp, maxhp, gold, exp, level, prop, sid, fame, race, dext, str, luck from userexts where uid='#{enemy_id}'")
       # enemy = r[0]
        enemy = User.find(enemy_id)
        p enemy.inspect
        
        sid = cookies[:_wh_session]
        p "session uid = #{session[:uid]}"
        if session[:uid]
          #  r = Userext.find_by_sql("select uid, name, hp, maxhp, gold, exp, level, prop, sid, fame, race, dext, str, luck from userexts where uid=#{session[:uid]}")
            r = User.find(session[:uid])
            player = r
        else
         #    r = Userext.find_by_sql("select uid, name, hp, maxhp, gold, exp, level, prop, sid, fame, race, dext, str, luck from userexts where sid<>'#{sid}'")
             r = User.find_by_sql("select * from users where sid='#{sid}'")
             player = r[0]
             session[:uid] = player[:uid]
        end
    
        p "session id #{sid}"
        if player[:sid] != sid
            p "=>>>> uid not correct"
              r = User.find_by_sql("select * from users where sid='#{sid}'")
             player = r[0]
             session[:uid] = player[:uid]
        end
        msg = ""
        p player.ext
        player[:isUser] = true
        enemy[:isUser] = false
        # calculate who attach first
        if (player.ext[:dext] > enemy.ext[:dext])
            attacker = player
            defenser = enemy
        else
            attacker = enemy
            defenser = player
        end
        
        msg += "#{attacker.ext[:name]} 抢先发动了进攻!\n"
        p attacker.inspect
        attacker_skills = Userskill.find_by_sql("select * from userskills where uid='#{attacker.ext[:uid]}' and enabled=1")
        defenser_skills = Userskill.find_by_sql("select * from userskills where uid='#{defenser.ext[:uid]}' and enabled=1")
        attacker_prop = JSON.parse(attacker.ext[:prop])
        defenser_prop = JSON.parse(defenser.ext[:prop])
        
        p attacker_skills.inspect
          p defenser_skills.inspect
        
        # what weapon attacker is wielding
        hand_weapon = attacker_prop[:hand_weapon]
        # defaut is unarmed
        weapon_type = 'unarmed'
        reg = /unarmed/i
        if (hand_weapon)
            weapon_type = query_obj(hand_weapon, "type", nil)
            reg = Regexp.new("#{weapon_type}", true)
        end

       context_a = {
                    :user => attacker,
                    :thisskill => nil,
                    :skills=>attacker_skills,
                    :target => defenser
        }
        # attacker choose the best dodge skill
        attacker[:dodge_skill] = choosBestDodgeSkill(context_a)
        # attacker choose the skill have best damage
        attacker[:attack_skill] = choosBestAttackSkill(context_a, weapon_type)
        # attacker choose best defense skill
        attacker[:defense_skill] = choosBestDefenseSkill(context_a, weapon_type)
        
        context_d = {
                    :user => defenser,
                    :thisskill => nil,
                    :skills=>   defenser_skills,
                    :target => attacker
        }
        # defenser choose the best dodge skill
        defenser[:dodge_skill] = choosBestDodgeSkill(context_d)
        # defenser choose the skill have best damage
        defenser[:attack_skill] = choosBestAttackSkill(context_d, weapon_type)
        # defenser choose best defense skill
        defenser[:defense_skill] = choosBestDefenseSkill(context_d, weapon_type)      
        
        
        srand(Time.now.tv_usec.to_i)
        gain = {
            :exp =>0,
           # :hp =>0,
           # :stam =>0,
            :pot => 0,
            :level =>0,
            :skills =>{
                attacker[:dodge_skill][:skill][:skname] =>
                {
                    :skill => attacker[:dodge_skill][:skill][:skname],
                    :point => 0,
                    :level => 0
                },
                attacker[:attack_skill][:skill][:skname] =>
                {
                    :skill => attacker[:attack_skill][:skill][:skname],
                    :point => 0,
                    :level => 0
                },
                attacker[:defense_skill][:skill][:skname]=>
                {
                    :skill => attacker[:defense_skill][:skill][:skname],
                    :point => 0,
                    :level => 0
                }
            }
        }
        i = 0
        style_c = "user"
        while (i < 100 )
            if  style_c == "user"
               style_c = "enemy"
            else
                style_c = "user"
            end
            
             msg += "<div class=\"#{style_c}\">\n";
            i = i+1
            # do attack
            context_a = {
                    :user => attacker,
                    :skills=> attacker_skills,
                    :target => defenser,
                    :gain => gain,
                    :msg => ""
            }
            context_d = {
                    :user => defenser,
                   # :thisskill => defenser[:dodge_skill][:skill],
                    :skills=>   defenser_skills,
                    :target => attacker,
                    :gain => gain,
                    :msg => ""
            }
            query_skill(attacker[:attack_skill][:skill][:skname], "doAttack", attacker[:attack_skill][:skill], context_a)
                
          #  dname = attacker.query_skill(attacker[:attack_skill][:skill][:skname]).dname
          #   msg += "<br/>\n【#{dname}】"+translate_msg(context_a[:msg], context_a)
               
               msg += "<br/>\n"+translate_msg(context_a[:msg], context_a)
              
             #
             # hit ?
             #
             
             p "attack skill #{attacker[:attack_skill][:skill][:skname]} level=#{attacker[:attack_skill][:skill][:level]}\n"
             p "dodage skill #{defenser[:dodge_skill][:skill][:skname]} level=#{defenser[:dodge_skill][:skill][:level]}\n"
    
           #  attack_speed = query_skill(attacker[:attack_skill][:skill][:skname], "power", attacker[:attack_skill][:skill], context_a)
                attack_power = skill_power(attacker[:attack_skill][:skill][:skname], context_a)
           #  defenser_speed = query_skill(defenser[:dodge_skill][:skill][:skname], "power", defenser[:dodge_skill][:skill], context_d)
                defense_power = skill_power(defenser[:dodge_skill][:skill][:skname], context_d)
          
             p "attack_power(#{attacker[:user]}) speed=#{attack_power}\n"
             p "defense_power(#{defenser[:user]}) speed=#{defense_power}\n"
             if rand(attack_power+defense_power) < defense_power # miss
                 #
                 # attack missed
                 #
                 context_a[:msg] = "";
                 query_skill(defenser[:dodge_skill][:skill][:skname], "doDodge", defenser[:dodge_skill][:skill], context_d)
                 msg += "<br/>\n"+translate_msg(context_d[:msg], context_d)
                 
                 # improve dodge skill
                 if (player[:id] == defenser[:id] && rand(player.ext[:it]+1) > 10)
                    
                    gain[:exp] += 1
                    player.ext[:exp] += 1
                    
                    gain[:pot] += 1
                    player.ext[:pot] += 1
                    
                    
                    gain_point = 1
                    gain[:skills][defenser[:dodge_skill][:skill][:skname]][:point] += gain_point
                    msg += "<br/> 战斗经验+1 潜能+1 #{defenser.query_skill(defenser[:dodge_skill][:skill][:skname]).dname}+#{gain_point}"
                    if (improve_skill(player, defenser[:dodge_skill][:skill][:skname], gain_point) )
                         gain[:skills][defenser[:dodge_skill][:skill][:skname]][:level] +=1
                         msg +="<br/> #{defenser[:dodge_skill][:skill][:skname]} level up !"
                     end
                   
                 end
                 # TODO should lose energy and first-attackdefenser[:defense_skill]
             else
                 
                 # 
                 # hit, check parry
                 #
                 
                 #check whether parry take effect pow(parry)+pow(weapon)>=pow(attack)+pow(weapon)
       
                 if (!defenser[:defense_skill]) # no parry
                    msg += doDamage(attacker[:attack_skill],context_a)
                    # gain exp and skill point
                    if (attacker[:user][:isUser]&& rand(player.ext[:it]+1) > 10)        
                        gain[:exp] += 1
                        player.ext[:exp] += 1
                        gain[:pot] += 1
                        player.ext[:pot] += 1
                        gain_point = 1
                        gain[:skills][attacker[:attack_skill][:skill][:skname]][:point] += gain_point
                        msg += "<br/> 战斗经验+1 潜能+1 #{attack.query_skill(attacker[:attack_skill][:skill][:skname]).dname}+#{gain_point}"
                        if (improve_skill(player, attacker[:attack_skill][:skill][:skname], gain_point) )
                             gain[:skills][attacker[:attack_skill][:skill][:skname]][:level] +=1
                            msg +="<br/> #{attacker[:attack_skill][:skill][:skname]} level up !"
                         end
                    end
                 else
                     context_d[:thisskill] = defenser[:defense_skill][:skill]
                     power_parry = query_skill(defenser[:defense_skill][:skill][:skname], "power", defenser[:defense_skill][:skill], context_d)
                     power_weapon_def = 0
                    # TODO get power of weapon
                   #  query_obj(objname, method, obj, context)
                     power_attack = query_skill(attacker[:attack_skill][:skill][:skname], "power", attacker[:attack_skill][:skill], context_d)
                      power_weapon_att = 0
                    # TODO get power of weapon
                   #  query_obj(objname, method, obj, context)
  
                    p "power_parry=#{power_parry} + power_weapon_def=#{power_weapon_def}"
                    p "power_attack=#{power_attack} + power_weapon_att=#{power_weapon_att}"
                    if (power_attack == 0 && power_weapon_att == 0)
                        power_attack = 1
                    end
                    if (power_parry==0 && power_weapon_def == 0)
                        power_parry = 1
                    end
                   p "rand #{rand(power_parry + power_weapon_def + power_attack + power_weapon_att)}"
                    p power_attack + power_weapon_att
                     if (rand(power_parry + power_weapon_def + power_attack + power_weapon_att) >= power_attack + power_weapon_att) # can parry
                           #
                           # parry succeeded
                           #
                           msg += doParry(defenser[:defense_skill], context_d)
                            if (player[:id] = defenser[:id]&& rand(player.ext[:it]+1) > 10)
                                 gain[:exp] += 1
                                 player.ext[:exp] += 1
                                gain[:pot] += 1
                                player.ext[:pot] += 1
                                 gain_point = 1
                                 gain[:skills][defenser[:defense_skill][:skill][:skname]][:point] += gain_point
                                 msg += "<br/> 战斗经验+1 潜能+1 #{defenser.query_skill(defenser[:defense_skill][:skill][:skname]).dname}+#{gain_point}"
                                 if (improve_skill(player, defenser[:defense_skill][:skill][:skname], gain_point) )
                                     gain[:skills][defenser[:defense_skill][:skill][:skname]][:level] +=1
                                     msg +="<br/> #{defenser[:defense_skill][:skill][:skname]} level up !"
                                 end
                            end
                     else
                         #
                         # failed in parrying
                         #
                         # do damage
                        msg += doDamage(attacker[:attack_skill], context_a)
                                if (attacker[:isUser] && rand(player.ext[:it]+1) > 10)
                                    gain[:exp] += 1
                                    player.ext[:exp] += 1
                                    gain[:pot] += 1
                                    player.ext[:pot] += 1
                                    gain_point = 1
                                    gain[:skills][attacker[:attack_skill][:skill][:skname]][:point] += gain_point
                                    msg += "<br/> 战斗经验+1 潜能+1 #{attacker.query_skill(attacker[:attack_skill][:skill][:skname]).dname}+#{gain_point}"
                                    if (improve_skill(player, attacker[:attack_skill][:skill][:skname], gain_point) )
                                        gain[:skills][attacker[:attack_skill][:skill][:skname]][:level] +=1
                                        msg +="<br/> #{attacker[:attack_skill][:skill][:skname]} level up !"
                                    end
                                end
                     end
                 end
                 
             end
             
             # show status
             msg += "<br/>\n#{attacker[:user]}  hp:#{attacker.tmp[:hp]} 体力:#{attacker.tmp[:stam]}\n<br/>"
             msg += "#{defenser[:user]}  hp:#{defenser.tmp[:hp]} 体力:#{defenser.tmp[:stam]}\n<br/>"
             
             msg += "</div>\n";
            
             if (defenser.tmp[:hp] <=0 )
                 msg += "<br/>#{defenser[:user]}战斗不能"
                 break;
             end
             # swap
             t = defenser
              defenser =  attacker
             attacker = t
             
             t = attacker_skills
             attacker_skills = defenser_skills
             defenser_skills = t
            
      
        end
    
      # save to db
        if (gain[:exp] != 0 )
            if ( (player.ext[:level]+1)*(player.ext[:level]+1)*(player.ext[:level]+1)<= player.ext[:exp])
                gain[:level] = 1
                player.ext[:level] += 1
                player.ext[:exp] = 0
            end
            player.ext.save!
        elsif (gain[:pot] != 0 )
            player.ext.save!
        end
        session[:userdata][:userext] = player.ext
        gain[:skills].each {|k, v|
            p "=>skill #{k}, #{v[:point]}, #{v[:level]}"
            if v[:point] != 0 || v[:level] != 0
          
                skill = player.query_skill(k).data
                p skill.inspect
                skill.save!
                p "save #{player.query_skill(k).data}"
            end
        }
        if (attacker[:isUser])
            msg +="<br>\nYou(#{attacker[:user]}) Win !"
        else
            msg += "<br>\nYou(#{defenser[:user]}) Lose !"
        end
        msg += "(in #{i} rounds)<br/>\n"
        ret = {
            "win" => attacker[:isUser],
            "gain" => gain,
            "msg"  => "<div style='background:black;color:white;font-size:12pt;'><style>div.user{color:#eeeeee}div.enemy{color:#ee6666}</style>#{msg}</div>"
        }
       # p msg
       if (params[:debug])
        render :text=>"<div style='background:black;color:white;font-size:12pt;'><style>div.user{color:#eeeeee}div.enemy{color:#ee6666}</style>#{msg}</div>" + gain.to_json
    else
        render :text=>ret.to_json
    end
    end
    
    def practise
        return if !check_session
        use_pot = params[:pot] # use how much potential
        skill_name = params[:skill]
        
        ud = user_data
        ext = user_data[:userext]
        pot = ext[:pot]
        if pot <= 0
            error ("You don't have enough potential")
            return
        end
        
        # get skill
      #  User user = session[:userdata]
       # skill = user.query_skill(skill_name)
        rs = Userskill.find_by_sql("select * from userskills where skname='#{skill_name}' and uid=#{session[:uid]}")
        if (rs.size <0 || rs[0] == nil)
            error("User doesn't has this skill")
            return
        end
        
        # calculate skillpoint
        gain = use_pot # maybe need change algorithm
        skill = rs[0]
        e = ext[:exp]
        for i in 1..ext[:level]
            e+= i*i*i
        end
        p "total exp #{e}, level #{ext[:level]} tempexp:#{ext[:exp]}"
        if (rs[0][:tp] + 1 >= rs[0][:level]*rs[0][:level])
            if (rs[0][:level] +1) * (rs[0][:level] +1) *(rs[0][:level] +1)/10>e
                error "You need more battle experience"
                return
            end
            rs[0][:level] += 1
            rs[0][:tp] = 0
        else
            rs[0][:tp] +=1
        end
        rs[0].save!
        
        ext[:pot] -= 1
        ext.save!
        
    

        p ext.inspect
            p ud[:userext].inspect
        ret = {
            :userskill=>rs[0],
            :user => ud
        }
        p ret.to_json
       # ret = ud.join(rs[0])
        render :text=>ret.to_json
        
    end
    
    def summary
        sid = params[:sid]
        
    end
end
