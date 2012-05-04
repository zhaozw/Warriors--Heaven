require 'json'
require 'objects/player.rb'
require 'objects/npc/npc.rb'
#require 'objects/skills/skill.rb'
require 'fight.rb'

class WhController < ApplicationController
    
    def test
  
   #cookies[:_wh_session]=""
 #  destroy_session
 #   reset_session
   # session[:fdsf]="fsfs"
   #     cookies["sid"] = ActiveSupport::SecureRandom.hex(16)
      #     session[:a] = "b"
      if session[:a]
        session[:a] = "b" 
        else
             session[:a] ="not exist"
         end
        
        #render :text=>cookies.to_json+session.to_json#+env[ENV_SESSION_KEY]
        render :text=>"fdsf"
    end
    def index

        p "cookie=#{cookies}"
       # session[:name]="ju"
    #    ret = {
     #       "uid" => "ju"
      #  }


=begin     
      sid = cookies[:_wh_session]

      # for test
      if (params[:sid])
          sid = params[:sid]
      end
        user = User.find_by_sql("select id, user, sid, sex, race, age, title from users where sid='#{sid}'")
   #     r = User.find_by_sql("select user, uid, sid, sex, race, age from users where sid='d434740f4ff4a5e758d4f340d7a5f467'")
        if (!sid)
            error "session not exist"
            return
        end
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
=end
         return if !check_session or !user_data
        # user_data.ext
         user_data.query_all_skills
         recoverPlayer(user_data.ext)
         recoverZhanyi(user_data.ext)
         render :text=>user_data.to_json
    end
    
    def reg
        
      #  r=User.get(1)
      #  p "==>changed=#{r.changed?}, changes=#{r.changes.inspect}"
     #   return
        
        
        sid = ActiveSupport::SecureRandom.hex(16)
        cookies[:_wh_session] = {
               :value => sid,
               :expires => 1.year.from_now,
               :domain => request.host
           }
        session[:username] = params[:name]
        p "=====>>>#{session['_wh_session']}"
        sex =  (params[:profile].to_i+1)/2 - (params[:profile].to_i) /2  # odd:1 even:0
        r = User.new({
            :user=>params[:name],
            :sid=>sid,
             :age=>16,
             :race=> 0,
             :sex=> params[:profile],
             :title=> "新人",
             :profile=>params[:profile]
            
        })
        p "===>save!1#{r.class}"
        begin
            r.save!
            p "===>save!2"
        rescue  Exception=>e
            p e
            if /Mysql::Error: Duplicate entry/.match(e)
                error ("名字已被使用")
            else
                error("Cannot create user with name #{params[:name]}")
            end
            return 
        end
        
        # init userext
        ext = Userext.new({
            :uid  => r[:id],
            :name => r[:user],
            :gold => 100,
            :exp  =>    0,
            :level=>    0,
            :prop => '{"max_eq":"5", "max_item":"10", "teamnotcreated":"1"}',
            :sid  => sid,
            :hp   => 100,
            :maxhp=> 100,
            :stam => 100, 
            :maxst=>  100,
            :str  =>  20,
            :dext =>  20,
            :luck =>  50,
            :fame => 0,
            :race => "human",
            :pot  =>  100,
            :it   =>  20,
            :max_jl => 100,
            :jingli => 100
        })
        ext.save!
        r[:userext] = ext
        
        # init skill
             r[:userskills]  = []
        skill = r[:userskills].push(skill)
                skill = Userskill.new({
            :uid    =>  r[:id],
            :sid     => sid,
            :skid    => 0,
            :skname  => "unarmed",
            :skdname => "",
            :level   => 0,
            :tp      => 0,
            :enabled => 1
        })
        skill.save!
     r[:userskills].push(skill)
     
       skill =  Userskill.new({
            :uid    =>  r[:id],
            :sid     => sid,
            :skid    => 0,
            :skname  => "parry",
            :skdname => "",
            :level   => 0,
            :tp      => 0,
            :enabled => 1
        })
        skill.save!

        r[:userskills].push(skill)
                
        skill = Userskill.new({
            :uid    =>  r[:id],
            :sid     => sid,
            :skid    => 0,
            :skname  => "dodge",
            :skdname => "",
            :level   => 0,
            :tp      => 0,
            :enabled => 1
        })
        skill.save!
        r[:userskills].push(skill)
        
        
        
        
        
        render :text=>r.to_json
        
        
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
       r = Userext.find_by_sql("select uid, lastact, updated_at, zhanyi, name, hp, maxhp, gold, exp, level, prop, sid, fame, race, dext, str, luck from userexts where sid<>'#{sid}' and zhanyi>30 limit #{start}, #{pagesize}")
       if (r.size >0)
           for rr in r
               rr[:status] = ""
               
               if rr[:updated_at] && (Time.now - rr[:updated_at]) < 10
                   if (rr[:lastact] == "fight")
                       rr[:status] = "战斗中"
                   elsif (rr[:lastact] == "practise")
                       rr[:status] = "练习中"
                   elsif (rr[:lastact] == "research")
                       rr[:status] = "研究中"
                   elsif (rr[:lastact] == "buy")
                       rr[:status] = "shopping中"
                   elsif (rr[:lastact] == "sell")
                       rr[:status] = "交易中"
                   elsif (rr[:lastact] =~ /quest_.*/)
                       rr[:status] = "#{rr[:lastact].form(6)}"                       
                   end
               end
           end
            js = r.to_json
        else
            error("record not found")
            return
        end
        render :text=>js
        
    end
    
 
    

    
    def render_skill (context)
        
    end
    
 
    def recoverZhanyi(ext, save=false)
        if (ext[:zhanyi] >= 100)
            ext[:zhanyi] -= 30
            ext.save if save
            return true
        end
        diff = Time.now - ext[:updated_at]
        ext[:zhanyi] += diff/36    # recover 100 per hour
        if ( ext[:zhanyi] > 100)
             ext[:zhanyi] = 100
        end
        
        if (ext[:zhanyi] > 30)
            ext[:zhanyi] -= 30
            ext.save if save
            return true 
        else
            return false
        end 
    end
    
    def recoverPlayer(ext)
#        p "update time #{ext[:updated_at].class}"
 #       p "now #{Time.now.class}"
        if (!ext || !ext[:updated_at])
            return
        end
        diff = Time.now - ext[:updated_at]
        
        if ext[:hp] < ext[:maxhp]
            ext[:hp] += ext[:maxhp] * diff /200  # maxhp/20 * (diff/10)
            if (ext[:hp] > ext[:maxhp])
                ext[:hp] = ext[:maxhp]
            end
        end
        
        
                
        if ext[:stam] < ext[:maxst]
            ext[:stam] += ext[:maxst] * diff /200  # maxhp/20 * (diff/10)
            if (ext[:stam] > ext[:maxst])
                ext[:stam] = ext[:maxst]
            end
        end
        
                
        if ext[:jingli] < ext[:max_jl]
            ext[:jingli] += ext[:max_jl] * diff /200  # maxhp/20 * (diff/10)
            if (ext[:jingli] > ext[:max_jl])
                ext[:jingli] = ext[:max_jl]
            end
        end
        
        p "recover finish: hp:#{ ext[:hp]}, st:#{ext[:stam]}, jingli:#{ext[:jingli]}"
    end
 
    # /wh/fight?:enemy=<user id>    
    def fight2
=begin
         r = Team.find(1)
         #r[:stam] = 90
         p "=====>>>ddd #{r.changed?}"
         return 
=end
=begin
        u = User.find(1)
        h = {
            "1"=>"dfaaf",
            "2"=>"fasf",
            "3"=>u
        }
        $memcached.set("113", h)
        logger.info $memcached.get("113")["3"].inspect
=end
=begin
      #  User.new({})
        r = User.get(1)
       # r[:c]  = 11111
       # p "==>1=#{r[:c]}"
        p r.inspect
       # p "--->#{r.psuper.class}"
        
       # r.ext[:stam] = 98
        r.check_save
        return
=end
        return if !check_session or !user_data
         
        recoverPlayer(user_data.ext)
        
       if (user_data.ext[:hp] <= 0)
           error("你的hp不够，不适合战斗")
           return
       end
        
        srand(Time.now.to_i)
        rmsg = [
            "你的体力不够，好好休息下再来吧",
            "你的体力不够，别浪费服务器资源了"
            ]
        if (user_data.ext[:stam] <= 0)
            error(rmsg[rand(1)])
            return
        end
        
        
        enemy_id = params[:enemy]
        enemy = User.get(enemy_id)
        p enemy.inspect
        if !recoverZhanyi(enemy.ext, false)
            error ("#{enemy[:user]}目前不愿作战")
            return
        end
      
=begin
        sid = cookies[:_wh_session]
        p "session uid = #{session[:uid]}"
        if session[:uid]
             r = User.find(session[:uid])
            player = r
        else
             r = User.find_by_sql("select * from users where sid='#{sid}'")
             player = r[0]
             session[:uid] = player[:id]
        end
=end
        player = user_data
        # indicate who is the client, here isUser not same meaning with .isUser 
        player[:isUser] = true
        enemy[:isUser] = false
        
        player.ext[:lastact] = "fight"
        enemy.ext[:lastact] = "fight"
 
        
        p1 = Player.new
        p p1.class
        p1.set_data(player)
        p2 = Player.new
        p2.set_data(enemy)
        
        p2.set_temp("hp", p2.ext[:maxhp])
        p "===> p2.hp=#{p2.ext[:hp]}, p2.hp=#{p2.tmp[:hp]},#{p2.query_temp("hp")}"
        p2.set_temp("stam", p2.ext[:maxst])
        p "===> p2.maxst=#{p2.ext[:maxst]}, p2.st=#{p2.query_temp("stam")}"
        
        context = {
            :msg => ""
        }
        
        result = _fight(p1, p2, context)
        
        #p "=>1: #{user_data[:userext] }"
        #p "=>2: #{ player.ext}"
       # user_data[:userext] = player.ext
        p "===>player.ext:#{player.ext.inspect}"
      #  user_data[:userext]=nil
        ret = {
            "user" => user_data,
            "win" => result,
            "gain" => player[:gain],
            "msg"  => "<div style='background:black;color:white;font-size:11pt;'><style>div.user{color:#eeeeee}div.enemy{color:#ff8888}.npc{color:#ff0000}.damage{color:#ff0000;}.status{font-size:10pt;}.rgain{color:yellow;font-size:10pt;}.rgain span{color:#99ff99}.attr{color:#99ff99}</style>#{context[:msg]}</div>"
        }
        winner = 0
        winner = 1 if !result
        b = Battle.new({
            :attacker =>  user_data[:user],
            :defenser =>  enemy[:user],
            :ftype     =>  0,
            :status   =>  0,
            :winner   =>  winner,
            :prop     =>  ""
        })
        b.save!
        
       # enemy.ext.save
        user_data.check_save
        enemy.check_save
        
         # p msg
        if (params[:debug])
           render :text=>"<div style='background:black;color:white;font-size:12pt;'><style>div.user{color:#eeeeee}div.enemy{color:#ff8888}</style>#{context[:msg]}</div>" + player[:gain].to_json
        else
            p "===>>>ppp"+ret.inspect
            render :text=>ret.to_json
        end
      #  render :text=>context[:msg]
    end
    
    
    
    def fight3
       # reset_session
        check_session
        
         user =   Player.new

        user.set_data(user_data)
           npc = create_npc("objects/npc/shanzei")
            npc.set_temp("level", user.ext[:level])
           
        context={:msg=>""}
            _fight(user, npc, context)
             render :text=>"<div style='background:black;color:white;font-size:12pt;'><style>div.user{color:#eeeeee}div.enemy{color:#ee6666}</style>#{context[:msg]}</div>" + user[:gain].to_json
   
    end
    
=begin   
    # /wh/fight?:enemy=<user id>
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
        if (player.tmp[:dext] > enemy.tmp[:dext])
            attacker = player
            defenser = enemy
        else
            attacker = enemy
            defenser = player
        end
        
        msg += "#{attacker.name} 抢先发动了进攻!\n"
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
            attacker_attack_skill.doAttack(context_a)
           # query_skill(attacker[:attack_skill][:skill][:skname], "doAttack", attackerattack_skill][:skill], context_a)
                
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
       # session[:userdata][:userext] = player.ext
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
            "msg"  => "<div style='background:black;color:white;font-size:12pt;'><style>div.user{color:#eeeeee}div.enemy{color:#ff8888}</style>#{msg}</div>"
        }
       # p msg
       if (params[:debug])
        render :text=>"<div style='background:black;color:white;font-size:12pt;'><style>div.user{color:#eeeeee}div.enemy{color:#ff8888}</style>#{msg}</div>" + gain.to_json
    else
        render :text=>ret.to_json
    end
    end
=end    
    def practise
        return if !check_session
        recoverPlayer(user_data.ext)
        use_pot = params[:pot] # use how much potential
        skill_name = params[:skill]
        
        ud = user_data

        ext = user_data.ext
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
        e = ext[:exp] + calc_total_exp(ext[:level])
        
        p "total exp #{e}, level #{ext[:level]} tempexp:#{ext[:exp]}"
        if (rs[0][:tp] + 1 >= (rs[0][:level]+1)*(rs[0][:level]+1))
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
        ext[:stam] -=5
        ext[:jingli] -=1
        
        
    
        user_data.check_save
        p ext.inspect
            p ud.ext.inspect
        ret = {
            :userskill=>rs[0],
            :user => ud
        }
        p ud.to_json
        p rs[0].to_json
        p "===>ppp#{ret.inspect}"
        p "#{ret.to_json}"
       # ret = ud.join(rs[0])
        render :text=>ret.to_json
        
    end
    
    def summary
        return if !check_session || !user_data
        sid = params[:sid]
        
        t = Time.now - 3600*24
        p t.to_s
        @battles = Battle.find_by_sql("select * from battles where defenser='#{user_data[:user]}' and status=0 and ftype=0 group by winner")
        @win_count = 0
        for b in @battles
            @win_count +=1 if b[:winner] == 1
        end
        p "====>last day, battle #{@battles.size}, win #{@win_count}"
        
        a = Battle.find_by_sql("select count(*) from battles where defenser='#{user_data[:user]}' or attacker='#{user_data[:user]}' and status=0 and ftype=0 ")
        b = Battle.find_by_sql("select count(*) from battles where (defenser='#{user_data[:user]}' and winner=1) or (attacker='#{user_data[:user]}' and winner=0) and status=0 and ftype=0 ")
        
        @battle_count = 0
         @battle_count =  a[0][0] if a[0][0]
        @total_win = 0
        @total_win = b[0][0] if b[0][0]
        p "===> total battle #{@battle_count}, win #{@total_win}"
        
        @rate = @total_win*1.0/@battle_count
        
        
    end
end
