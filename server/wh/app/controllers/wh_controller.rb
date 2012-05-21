require 'json'
require 'objects/player.rb'
require 'objects/npc/npc.rb'
#require 'objects/skills/skill.rb'
require 'fight.rb'

class WhController < ApplicationController
    
    def test
        Process.detach fork{
            sleep 10
            p "sdfsasafsafs"
        }
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
         user_data.query_all_obj
         recoverPlayer(user_data.ext)
         recoverZhanyi(user_data.ext)
         update_task(user_data)

         npc = create_npc("objects/npc/hero/#{hero_name}")
         user_data[:hero]={
             :lengendImage => npc.lengendImage
         }
         render :text=>user_data.to_json
         
         user_data.check_save
    end
    
    def ext
        return if !check_session and !user_data
        player.recover
        render :text=>user_data.ext.to_json
        return 
    end
    def check_practise(pending, context=nil)
        t = pending["t"]
        t_span = Time.now.to_i - t
        
        
        usepot =  pending["usepot"].to_i
                skill = player.query_skill(pending["skill"])
         p "==>pending skill = #{pending["skill"]}, #{skill.inspect}"       
        up = player.practise(skill, t_span)
        ret = pending.clone
        if up[:usepot] >= pending["usepot"].to_i
            ret = {}
        else
            ret["t"] = Time.now.to_i
            ret["usepot"] = pending["usepot"].to_i - up[:usepot]
        end
        
        p "=>up=#{up.inspect}, #{context.inspect}"
        if (context)
            if (up[:levelup] )
                 context[:msg]+="修练完毕，消耗#{up[:usepot]}点潜能, 精力-#{up[:cost_jingli]}, 技能点增加#{up[:addtp]}, 恭喜你的#{skill.dname}等级提高了!"
            else
                 context[:msg]+="修练完毕，消耗#{up[:usepot]}点潜能, 精力-#{up[:cost_jingli]}, 技能点增加#{up[:addtp]}"
            end 
        end
        
        return ret
    end
    
    def update_task(ud)
        pending = ud.ext.get_prop("pending")
        if !pending
            return
        end
        if pending.class == String
            pending = JSON.parse(pending)
        end
        if !pending["act"]
            return
        end
=begin       
        t = pending["t"]
        t_span = Time.now.to_i - t
        
        
        usepot =  pending["usepot"].to_i
        player = Player.new
        player.set_data(ud)

        skill = player.query_skill(pending["skill"])
         p "==>pending skill = #{pending["skill"]}, #{skill.inspect}"       
        up = player.practise(skill, t_span)
        # if t_span > pending["usepot"].to_i # finished
        #     player.practise(pending["skill"], usepot)
        # else
        #     player.practise(pending["skill"], t_span)
        #     pending["t"] = Time.now.to_i
        #     pending["usepot"] = pending["usepot"] - t_span
        #     ud.ext.set_prop("pending", pending)
        # end
        if up[:usepot] >= pending["usepot"].to_i
            pending = {}
        else
            pending["t"] = Time.now.to_i
            pending["usepot"] = pending["usepot"].to_i - up[:usepot]
            ud.ext.set_prop("pending", pending)
        end
=end
       _pending = check_practise(pending)
        ud.ext.set_prop("pending", _pending)
        # ud.check_save
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
             :sex=> sex,
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
        return if !check_session or !user_data
        
       sid = cookies[:_wh_session]
       pagesize = params[:pagesize] || 10
       start = params[:start] || 0
       if !sid
            error("session not exist")
            return
        end
       r = Userext.find_by_sql("select uid, lastact, updated_at, zhanyi, name, hp, maxhp, gold, exp, level, prop, sid, fame, race, dext, str, luck from userexts where sid<>'#{sid}' and zhanyi>30 and level>#{user_data.ext[:level]-1} order by level limit #{start}, #{pagesize}")
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
                   elsif (rr[:lastact] = "idle")
                       rr[:status] = "发呆中"
                   elsif 
                       rr[:status] = ""
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
        # if (ext[:zhanyi] >= 100)
        #     ext[:zhanyi] -= 30
        #     ext.save if save
        #     return true
        # end
        diff = Time.now - ext[:updated_at]
        p "===> time diff #{diff}, #{ext[:zhanyi]}"
        ext[:zhanyi] += diff/36    # recover 100 per hour
        if ( ext[:zhanyi] > 100)
             ext[:zhanyi] = 100
        end
  
        if (ext[:zhanyi] > 30)
            # ext[:zhanyi] -= 30
            # ext.save if save
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
        player[:canGain] = true
        enemy[:isUser] = false
        enemy[:canGain] = false
        
        # player.ext[:lastact] = "fight"
        # enemy.ext[:lastact] = "fight"
 
        
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
        
        result = _fight(p1, p2, context) # 0: lose, 1: win
        
        
        if result == 0 
            # if  p1.tmp[:stam] < 0
                player[:gain][:drop] = []
                dr = rand_drop(p1, p2)
                player[:gain][:drop] = dr if dr
                dr = rand_drop_gold(p1, p2, (100-p1.tmp[:luck])/10)
                player[:gain][:drop].push({
                    :dname=>"Gold",
                    :unit=>"",
                    :amount=>dr
                }) if dr && ! player.query_obj("objects/special/goldkeeper")
                
                p "===>drop:#{dr.inspect}"
            # end
        elsif result == 1
             player[:gain][:object] = []
            rand_drop(p2, p1, (100 - enemy.ext[:luck])/20)
            player[:gain][:object] = dr if dr
            
            dr = rand_drop_gold(p1, p2, (100-p2.tmp[:luck])/10)
            player[:gain][:object].push({
                    :dname=>"Gold",
                    :unit=>"",
                    :amount=>dr
                })  if dr ! player.query_obj("objects/special/goldkeeper")
            
            p "===>drop:#{dr.inspect}"
        end
        
        #p "=>1: #{user_data[:userext] }"
        #p "=>2: #{ player.ext}"
       # user_data[:userext] = player.ext
        p "===>player.ext:#{player.ext.inspect}"
      #  user_data[:userext]=nil
      @context = context # for template render
      @context[:p1] = p1
      @context[:p2] = p2
        ret = {
            "user" => user_data,
            "win" => result,
            "gain" => player[:gain],
            "round" => context[:round],
            "msg"  => render_to_string(:layout=>false)
        }
        winner = 0
        winner = 1 if !result
        b = Battle.new({
            :attacker =>  user_data[:user],
            :defenser =>  enemy[:user],
            :ftype     =>  0,
            :status   =>  0,
            :winner   =>  winner, # 0: attacker win 1: enemy win
            :prop     =>  ""
        })
        b.save!
        
       # enemy.ext.save
       p "===>enemy zhanyi #{enemy.ext[:zhanyi]}"
        if (winner==0 && enemy.ext[:zhanyi] >= 0)
            enemy.ext[:zhanyi] -= 30
        end
        p "===>enemy zhanyi #{enemy.ext[:zhanyi]}, winner=#{winner}"
        
        # cleanup
        player[:isUser]=nil
        player[:gain] = nil
        player[:attack_skill] = nil
        player[:dodge_skill] = nil
        player[:defense_skill] = nil
        user_data.check_save
        enemy.check_save
        
     
        # return
        
         # p msg
        if (params[:debug])
           render :text=>"<div style='background:black;color:white;font-size:12pt;'><style>div.user{color:#eeeeee}div.enemy{color:#ff8888}</style>#{context[:msg]}</div>" + player[:gain].to_json
        else
            p "===>>>ppp"+ret.inspect
            render :text=>ret.to_json
        end
      #  render :text=>context[:msg]
    end
    
    def hero_name
        l = user_data.ext[:level]
             if l < 10
            name = "weizhangtianxin"
        elsif l < 20
            name = "weizhangtianxin"
        elsif l < 20
            name = "weizhangtianxin"
        elsif l < 20
            name = "weizhangtianxin"
        elsif l < 20
            name = "weizhangtianxin"
        elsif l < 20
            name = "weizhangtianxin"
        elsif l < 20
            name = "weizhangtianxin"
        end
        return name
    end

    def hero
        return if !check_session or !user_data
       
        npc = create_npc("objects/npc/hero/#{hero_name}")
        eqs = npc.query_all_wearings.values
        ret = {
            :name=>hero_name,
            :dname=>npc.name,
            :desc=>npc.desc,
            :title=>npc.title,
            :image=>npc.image,
            :homeImage=>npc.homeImage,
            :equipments=>eqs
        }
        render :text=>ret.to_json
    end
    
    def fightHero
        return if !check_session or !user_data
        name = params[:name]
        npc = create_npc("objects/npc/hero/#{hero_name}")         
        @fight_context = {:msg=>""}
        player[:isUser] = true
        player[:canGain] = true
        @win = _fight(player, npc, @fight_context )
        p "after fight hero #{player.inspect}"
        # cleanup
        player[:isUser]=nil
        player[:gain] = nil
        player[:attack_skill] = nil
        player[:dodge_skill] = nil
        player[:defense_skill] = nil
        user_data.check_save
        user_data.check_save
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
        time = t.strftime("%Y-%m-%d %H:%M:%S") 
        p t.to_s
        p time
        r =  ActiveRecord::Base.connection.execute("select count(*) from battles where defenser='#{user_data[:user]}' and status=0 and ftype=0 and updated_at>'#{time}'")
        @battle_count_last_day = r.fetch_row[0].to_i
        r =  ActiveRecord::Base.connection.execute("select count(*) from battles where defenser='#{user_data[:user]}' and winner=1 and status=0 and ftype=0 and updated_at>'#{time}'")
        @win_count_last_day =  r.fetch_row[0].to_i
        # @win_count = 0
        #  for b in @battles
        #      @win_count +=1 if b[:winner] == 1
        #  end
        # p "====>last day, battle #{@battles.size}, win #{@win_count}"
        
        a = ActiveRecord::Base.connection.execute("select count(*) from battles where defenser='#{user_data[:user]}' or attacker='#{user_data[:user]}' and status=0 and ftype=0 ")
        b = ActiveRecord::Base.connection.execute("select count(*) from battles where (defenser='#{user_data[:user]}' and winner=1) or (attacker='#{user_data[:user]}' and winner=0) and status=0 and ftype=0 ")
        @battle_count = a.fetch_row[0].to_i
        @total_win = b.fetch_row[0].to_i
        # p "#{b.inspect} / #{a.inspect}"
        # @battle_count = 0
        #          @battle_count =  a[0][0] if a.fetch_row[0].to_i
        #         @total_win = 0
        #         @total_win = b[0][0] if b[0][0]
        p "===> total battle #{@battle_count}, win #{@total_win}"
        
        
        
        @rate = @total_win*100.0/@battle_count
        
       r = ActiveRecord::Base.connection.execute("select count(*) from userquests where uid=#{session[:uid]}")
       @quest_count = QuestController.list.size - r.fetch_row[0].to_i
        
    end
    
    def startPractise
        return if !check_session || !user_data
        player.recover
        pending = user_data.ext.get_prop("pending")
        
        player= Player.new
        player.set_data(user_data)
        skill = player.query_skill(params[:skill])
        
        if ( pending )
            if (pending.class == String)
                pending = JSON.parse(pending)
            end
  
            if (pending["act"] != nil and pending["msg"]!=nil)
                _pending = check_practise(pending)
                if _pending &&_pending[:usepot] && _pending[:usepot] > 0
                    error ("你正忙着#{pending['msg']}呢!")
                    return
                end
            end
        end
  
        if ( user_data.ext[:pot] <= 0)
            error("你的潜能不够, 无法提高")
            return
        end
        if params[:userpot]
            usepot = params[:usepot].to_i
            if (usepot > user_data.ext[:pot])
                usepot =  user_data.ext[:pot]
            end
        else
            usepot = user_data.ext[:pot]
        end
        p "=>usepot1=#{usepot}"
      
        
        jingli = user_data.ext[:jingli].to_i
        it = user_data.ext[:it].to_i
        pot_support_by_jingli = jingli*it/20
        if pot_support_by_jingli < usepot
            usepot = pot_support_by_jingli
        end
                p "=>usepot2=#{usepot}"
   
        e = user_data.ext[:exp] + calc_total_exp(user_data.ext[:level])
        p "te=#{e} ////skill:#{skill.inspect}"
        level = skill[:level]
        max_pot = (skill[:level] +1) * (skill[:level] +1) - skill[:tp]
        if (skill[:level] +1) * (skill[:level] +1) *(skill[:level] +1)/10 <= e # can level up
            if improve_skill(player, params[:skill], 0) # level up-ed
                p "=>level up-ed"
                if (level+2)**3/10 <= e
                    max_pot = (level+2)**2
                else
                    max_pot = (level+2)**2-1
                end
            end
            
        else #cannot levelup
            max_pot -= 1
        
            # error ("你的战斗经验不够！")
        end
               p "=>max_pot=#{max_pot}"
        if max_pot < usepot
                usepot = max_pot
        end
        
     
        p "=>usepot3=#{usepot}"
        if (usepot > 0)
            pending = {
                :act=>'practise',
                :msg=>"修炼#{skill.dname}",
                :t =>Time.now.to_i,
                :skill=>params[:skill],
                :usepot => usepot
            }
            user_data.ext.set_prop("pending", pending)
            user_data.ext[:lastact] = "practise"
            user_data.check_save
            success("你开始修炼#{skill.dname}", {:skill=>params[:skill], :usepot=>usepot})
        else
            error("你的战斗经验似乎不够!")
        end
        return
    end
    
    def stopPractise
        return if !check_session || !user_data
        player.recover
        ext = user_data.ext
        _skillname=params[:skill]
        player   = Player.new
        player.set_data(user_data)
        pending = user_data.ext.get_prop("pending")
        if !pending 
            error "你不在修炼任何技能"
            return
        end
        
        p "pending=#{pending.inspect}"
        if pending.class==String
            pending = JSON.parse(pending)
        end
        
        if !pending["act"] or pending["act"]!='practise' or !pending["msg"]
            error "你不在修炼任何技能"
            return
        end
        
                
        skillname = pending["skill"]
        if skillname != _skillname
            error "你正在修炼的不是这项技能"
            return
        end
        skill = user_data.query_skill(skillname)
        
        usepot = pending["usepot"]
        
        # t = pending["t"].to_i
        # p  "start time #{t}"
        # st = Time.now.to_i
        # p "stoptime #{st}"
        # t_span = st -t
=begin        
        # calculate gain
        # int = 20 : consume 1 jingli per converting 1 pot per     
        int = user_data.ext[:it]
        pot = user_data.ext[:pot]
        # if (params[:pot] && params[:pot]< pot)
        #      pot =params[:pot]
        #  end 
        jingli = user_data.ext[:jingli]
        
        # cost_jingli_rate = int/20
        consume_pot = (st-t)*1 # cosume 1 pot per sec
        
        # max pot can be used limited by exp
        max_pot = usepot.to_i
        e = ext[:exp] + calc_total_exp(ext[:level])
        if (skill[:level] +1) * (skill[:level] +1) *(skill[:level] +1)/10>e
            max_pot = (skill[:level] +1) * (skill[:level] +1) - skill[:tp]
        end
              
        if consume_pot > max_pot
            consume_pot = max_pot
        end
        p "==>consume_pot = #{consume_pot.inspect}, int=#{int}"
        cost_jingli = consume_pot*20/int
        
        if cost_jingli > jingli
            cost_jingli = jingli
            consume_pot = cost_jingli*int/20
        end
        
        levelup = improve_skill(player, skillname, max_pot)
        
        user_data.ext[:jingli] -= cost_jingli
        user_data.ext[:pot] -= consume_pot      
        
=end
        # levelup = false
        #         level1 = skill[:level]
        #         skill = user_data.query_skill(skillname)
        #         ret = player.practise(skill, t_span)
        #         # if skill[:level] > level1
        #         #     levelup = true
        #         #     
        #         # end  
        #         
        #         
        #         
        #         pending = {}
        c = {:msg=>""}
        _pending = check_practise(pending, c)
        user_data.ext.set_prop("pending", _pending)
        
  
        _skill = JSON.parse(skill.to_json) # convert to has
        _ext = JSON.parse(user_data.ext.to_json)
        _ret = _skill.merge(_ext)
        
        success(c[:msg], _ret)
  
        user_data.ext[:lastact] = ""
        user_data.check_save
        return
    end
    
    def teamfight
        id = params[:id].to_i
            dir = id/100
            dir = "/var/wh/globalquest/"+dir.to_s+"/"
    path = dir + id.to_s
    r = ""
       # logger.info("$$$$$$$$$$:#{path}$$$")
    if FileTest.exist?(path) 
      f = File.new(path, "r") 
      f.each_line do |l|
        r = r + l
      end
      f.close
    else
      logger.error "file #{path} not exist!"
    end

        @fight_result =r
    end
end
