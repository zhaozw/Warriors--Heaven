require 'json'

class WhController < ApplicationController
    
    def index
        p "cookie=#{cookies}"
       # session[:name]="ju"
    #    ret = {
     #       "uid" => "ju"
      #  }
        r = User.find_by_sql("select id, user, sid, sex, race, age from users where sid='#{cookies[:_wh_session]}'")
   #     r = User.find_by_sql("select user, uid, sid, sex, race, age from users where sid='d434740f4ff4a5e758d4f340d7a5f467'")
        
        js = '{"error":"user not found"}'
        p r
        if (r.size >0)
            js = r[0].to_json
            session[:uid] = r[0][:id]
        end
        render :text=>js
    end
    
    def error(msg)
        render :text=>"{\"error\":#{msg}}"
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
    
    def load_skill (skillname)
             # eval skill class
                eval "require 'skills/"+ skillname+".rb'"
               
                target_class = skillname.at(0).upcase+skillname.from(1)
                targetObj=eval target_class+'.new()'
    end
    
    def query_skill(skillname, method, context)
         targetObj = load_skill(skillname)
         m = targetObj.method(method);
        if (method == "for" or method=="type")
             return m.call()
         else
             return m.call(context)
         end
    end
    
    def query_obj(objname, method, context)
        eval "require 'objects/"+ objname+".rb'"         
        target_class = objname.at(0).upcase+objname.from(1)
        targetObj=eval target_class+'.new()'
         m = targetObj.method(method);
  
             return m.call(context)
         
    end
    
    def chooseBestSkill(context, pur, weapon_type, prop)
            attacker_skills = context[:skills]
     
            attack_skill = {
                :skill => nil
            }
            attack_skill[prop] = 0
            reg2  = Regexp.new("#{pur}", true)
            if (weapon_type and weapon_type.length >0)
                reg = Regexp.new("#{weapon_type}", true)
            else
                reg = /./i
            end
            for skill in attacker_skills
                skillname = skill[:skname]
                context[:thisskill] = skill
                purpose = query_skill(skillname, "for", context)
                type = query_skill(skillname, "type", context)
                
                # if skill is for attacking and has correct type with weapon
                if type=~ reg and purpose=~reg2 
                    ret = query_skill(skillname, prop, context)
                    p "===>#{prop} of #{skillname}: #{ret} \n"
                    if (ret.to_i > attack_skill[prop])
                        attack_skill[prop] = ret
                        attack_skill[:skill] = skill
                    end
                end

                
                #p "target:"+@target_class+", cmd:"+@cmd+", param:"+@cparam
            end
            if ( attack_skill[:skill] == nil)
                #if not found, add basic skill for this type of skill
                Userskill us = {
                    :uid        =>  session[:uid],
                    :sid        =>  sid,
                    :skid       =>  0,
                    :skname     =>  weapon_type,
                    :skdname    =>  "basic #{weapon_type}",
                    :level      =>  0,
                    :tp         =>  0,
                    :enabled    =>  1   
                }
                us.Save!
                attacker_skills.append(us)
                attack_skill[:skill] = us
            end
            return attack_skill
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
    
            p "==>#{context[:userext][:name]} speed of #{attack_skill[:skill][:skname]}: #{attack_skill['speed']}"
            return attack_skill
    end
    
    def choosBestDefenseSkill(context, weapon_type)
        attack_skill = chooseBestSkill(context, "parry", nil, "defense")
    
        p "==> defense of #{attack_skill[:skill][:skname]}: #{attack_skill['defense']}"
        return attack_skill
    end
    
    
    def render_skill (context)
        
    end
    
    def translate_msg(msg, context)
        attacker = context[:userext]
      #  p attacker[:name] 
      #  p msg
        defenser = context[:target]
           if (attacker[:uid] == session[:uid])
                m = msg.gsub(/\$N/, "你").gsub(/\$n/, defenser[:name])
            else
                m = msg.gsub(/\$N/, attacker[:name]).gsub(/\$n/, "你")
            end
    end
    def fight
        
      
        enemy_id= params[:enemy]
        r = Userext.find_by_sql("select uid, name, hp, maxhp, gold, exp, level, prop, sid, fame, race, dext, str, luck from userexts where uid='#{enemy_id}'")
        enemy = r[0]
        
        sid = cookies[:_wh_session]
        p "session uid = #{session[:uid]}"
        if session[:uid]
            r = Userext.find_by_sql("select uid, name, hp, maxhp, gold, exp, level, prop, sid, fame, race, dext, str, luck from userexts where uid=#{session[:uid]}")
            player = r[0]
        else
             r = Userext.find_by_sql("select uid, name, hp, maxhp, gold, exp, level, prop, sid, fame, race, dext, str, luck from userexts where sid<>'#{sid}'")
             player = r[0]
             session[:uid] = player[:uid]
        end
    
        msg = ""
        # calculate who attach first
        if (player[:dext] > enemy[:dext])
            attacker = player
            defenser = enemy
        else
            attacker = enemy
            defenser = player
        end
        
        msg += "#{attacker[:name]} attach first\n"
        
        attacker_skills = Userskill.find_by_sql("select skid, skname, level, tp from userskills where uid='#{attacker[:uid]}' and enabled=1")
        defenser_skills = Userskill.find_by_sql("select skid, skname, level, tp from userskills where uid='#{defenser[:uid]}' and enabled=1")
        attacker_prop = JSON.parse(attacker[:prop])
        defenser_prop = JSON.parse(defenser[:prop])
        
        # what weapon attacker is wielding
        hand_weapon = attacker_prop[:hand_weapon]
        # defaut is unarmed
        weapon_type = 'unarmed'
        reg = /unarmed/i
        if (hand_weapon)
            weapon_type = query_obj(hand_weapon, "type", nil)
            reg = Regexp.new("#{weapon_type}", true)
        end

       context = {
                    :userext => attacker,
                    :thisskill => nil,
                    :skills=>   attacker_skills,
                    :target => defenser
        }
        # attacker choose the best dodge skill
        attacker_dodge_skill = choosBestDodgeSkill(context)
        # attacker choose the skill have best damage
        attacker_attack_skill = choosBestAttackSkill(context, weapon_type)
        # attacker choose best defense skill
        attacker_defense_skill = choosBestDefenseSkill(context, weapon_type)
        
        context = {
                    :userext => defenser,
                    :thisskill => nil,
                    :skills=>   defenser_skills,
                    :target => attacker
        }
        # defenser choose the best dodge skill
        defenser_dodge_skill = choosBestDodgeSkill(context)
        # defenser choose the skill have best damage
        defenser_attack_skill = choosBestAttackSkill(context, weapon_type)
        # defenser choose best defense skill
        defenser_defense_skill = choosBestDefenseSkill(context, weapon_type)      
        
        
        while (true)
            # do attack
            context = {
                    :userext => attacker,
                    :thisskill => attacker_attack_skill[:skill],
                    :skills=>   attacker_skills,
                    :target => defenser,
                    :msg => ""
            }
            query_skill(attacker_attack_skill[:skill][:skname], "render", context)
                
         
             msg += "\n"+translate_msg(context[:msg], context)
             
             # hit ?
             attacker_load = 0 # TODO should be calculated
             attack_speed = query_skill(attacker_attack_skill[:skill][:skname], "speed", context) - attacker_load
             
             defenser_load = 0
             defenser_speed = query_skill(defenser_dodge_skill[:skill][:skname], "speed", context) - defenser_load
        
             srand(Time.now.to_i)
             p "attacker speed=#{attack_speed}\n"
             p "defenser speed=#{defenser_speed}\n"
             if rand(attack_speed+defenser_speed) < defenser_speed # miss
                 context[:msg] = "";
                 query_skill(defenser_dodge_skill[:skill][:skname], "render", context)
                 msg += "\n"+translate_msg(context[:msg], context)
                 # TODO should lose energy and first-attack
             else # hit
                 #check whether parry take effect
                
             end
            break;
        end
      
        render :text=>msg
    end
end
