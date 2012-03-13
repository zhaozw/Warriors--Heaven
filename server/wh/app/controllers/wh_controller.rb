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
        
        attacker_skills = Userskill.find_by_sql("select skid, skname, level, tp from userskills where uid='#{attacker[:uid]}'")
        defenser_skills = Userskill.find_by_sql("select skid, skname, level, tp from userskills where uid='#{defenser[:uid]}'")
        
        while (true)
            # calculate 
            # choose the skill have best damage
            attack_skill = {
                :damage => 0,
                :skill => nil
            }
            for skill in attacker_skills
                skillname = skill[:skname]
                # eval skill class
                eval "require 'skills/"+ skillname+".rb'"
               
                target_class = skillname.at(0).upcase+skillname.from(1)
                targetObj=eval target_class+'.new()'
                m = targetObj.method("type");
                ret = m.call();
                if ret=~/attack/i
                    m = targetObj.method("damage");
                    ret = m.call(attacker, skill);
                    p "===>damage of #{skillname}: #{ret} \n"
                    if (ret > attack_skill[:damage])
                        attack_skill[:damage] = ret
                        attack_skill[:skill] = skill
                    end
                end
                #p "target:"+@target_class+", cmd:"+@cmd+", param:"+@cparam
            
            end
            
            p "#{attacker[:name]} choose attack skill #{attack_skill[:skill][:skname]}\n"
            break;
        end
    end
end
