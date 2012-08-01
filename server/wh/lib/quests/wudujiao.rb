require "quests/quest.rb"
require "fight.rb"
class Wudujiao < Quest 
    def dname
       "五毒教"
    end
    
    def desc
       "雲南五毒教は毒使いで有名。最近、中原にやってきて、各流派をチャレンジしているので、人手が必要である。" 
    end
    
    def type
    end

    def room
        
       qid = data.get_prop("quest_id")
       p "==>qid=#{qid.inspect}"
       if !qid
           return "ここは五毒教への必ず通らなければならない道である。前は黒山のような大山で、右は一つの道で、遠くには人や馬の音で賑やかで、沢山の人が集まっているようだ。中原武術界の人々が臨時に集まっている所だろう。"
       end
       
       q = globalq(qid)
       msg = ""
        if q[:stat] == 0
            if  data.get_prop("join") == "zhongyuan"
                msg += "<div>これは臨時的に作ったテントで、中原群雄の休憩のために使われる。</div>"
         
            else
                msg += "<div>これは広いロビーで、五毒教のメンバーや外部からの援助</div>"

            end


            return msg
        elsif q[:stat] == 1
            
            return "戦い進行中。現在、五毒教は#{q.get_prop("team1win")}回勝ち、中原武術界は#{q.get_prop("team2win")}回勝ち。"
        elsif q[:stat] == 2
            win = q.get_prop('win')
            r = ""
            case win
                when -1: r="勝負がつかない!"
                when 0: r="五毒教が勝った!"
                when 1: r="中原武術界が勝った!"
            end
            return "戦いが終了。五毒教が#{q.get_prop("team1win")}回勝ち、中原武術界が#{q.get_prop("team2win")}回勝ち。#{r}"
        end
    end
    
    def room_welcome
        qid = data.get_prop("quest_id")
        if !qid
            return ""
        end
        q = globalq(qid)
        msg = ""
        if q[:stat] == 0
            if  data.get_prop("join") == "zhongyuan"
              
                num = q.get_prop("zhongyuan").size
                per = num*100/full
            else
             
                num = q.get_prop("wudu").size
                per = num*100/full
            end
            if per > 80
                msg += "<div>あなたが周辺を見て、空いている席が基本的になさそうなので、戦いはそろそろ始まるだろう。"
            elsif per > 50
                msg += "<div>あなたが周辺を見て、空いている席がまだ沢山あるようで、もう少し待つだろう。"
            else
                msg += "<div>あなたが周辺を見て、空いている席がまだ沢山あるので、早く着いてしまったから、目を閉じて休憩する。"
            end

           elsif q[:stat] == 2
               gain = data.get_prop("gain")
               b_exp = get_prop(gain, "bonus_exp")
               b_gold = get_prop(gain, "bonus_gold")
               msg += "<div>戦い奨励として、あなたが#{b_exp}点経験をゲットした！"
               msg += "<div>戦い奨励として、あなたが#{b_gold}goldをゲットした！"
        end
         return msg
    end
    
    def onAsk(context)
        
        return true
    end   
            
    def action_list
       
        qid = data.get_prop("quest_id")
        p "====>action_list qid=#{qid}"
        if !qid
             return         [
            {
                :name=>"join_wudu",
                :dname=>"五毒教に加入"
            },
            {
                :name=>"join_zhongyuan",
                :dname=>"中原武術界に加入"
            },
        ]
        else
            q = globalq(qid.to_i)
                    p "====>action_list q=#{q.inspect}"
            if q[:stat] == 2
                return [
                    {
                        :name=>"check_result",
                        :dname=>"戦い実況録画"
                    
                    },
                    {
                        :name=>"restart",
                        :dname=>"改めて任務を受け取る"
                    
                    },
                    ]
            elsif q[:stat] == 1
                  return  [{
                        :name=>"check_result",
                        :dname=>"戦い生放送をチェック"
                    
                    }]
                 
            else
                return []
            end
        end
    end
    
    def onAction(context)
        player = context[:user]
        action = context[:action]
       
       msg = ""
           
       q = nil
       qid = data.get_prop("quest_id")
       # if qid
       #     q = globalq(qid)
       #     if q[:stat] > 1]
       #         qid=nil
       #     end
       # end
       if !qid # havn't join team
            
            # try to join
            # r = player.query_quest("wudujiao")
=begin
           if !r or r[:progress] < 100

            else
                        
                if action == "join_zhongyuan"
                    msg += "<div>你向右走上，来到群雄面前, 想要加入。</div>"
                    msg += "<div>左冷禅对你说：云南山岚瘴气甚多，无毒教更是遍布毒虫，小兄弟对草药一无所知，还是不要去送了性命。</div>"
                elsif action == "join_wudu"
                    msg += "<div>你向前进入无毒教地界。</div>"
                    msg += "<div>一个苗人打的年轻女子拦住了你：阁下百草不识，帮不上什么，不如请回吧。</div>"
                else 
                      msg += "<div>你要加入谁???</div>"
                end
                context[:msg] = msg
            
                return
            end
=end
      
            # passed check, set quest id
            rs = Globalquest.find_by_sql("select * from globalquests where stat=0")
            rs2 =  ActiveRecord::Base.connection.execute("select count(*) from globalquests where name='wudujiao'")
            battlecount = rs2.fetch_row[0].to_i
            if !rs or rs.size == 0 # not globalquest
                q = Globalquest.new({
                    :name=>"wudujiao",
                    :stat=>0,
                    :prop =>{
                        :wudu=>[],
                        :zhongyuan=>[],
                        :battle_count=>battlecount.to_i+1 # 第x次无毒教战役
                    }.to_json
                })
                q.save!
                data.set_prop("quest_id", q.id)
            else    # globalquest existing
                 data.set_prop("quest_id", rs[0].id)
                 # r = rs[0]
                 q = rs[0]
                 p "===>q1 = #{q.inspect}"
            end
    
      end
      
      # if q==nil
      #     q = globalq(qid)
      # end
      
      p "====>zhanyikaishi22, #{q.inspect}"           
      if action=="check_result"
          
          context[:script]="location.replace('/wh/teamfight?id=#{qid}');"
          return
      elsif action =="restart"
          data.set_prop("quest_id", nil)
          context[:room] = self.room
          # data.save!
          return
        
      else  
          
        # join
            team_zhongyuan = q.get_prop("zhongyuan")
            team_wudu =q.get_prop("wudu")
            team_joined = nil
            if team_zhongyuan.include?(player.id) 
                team_joined = "中原武術界"
            elsif  team_wudu.include?(player.id) 
                team_joined = "五毒教"
            end
            p "===>team_zhongyuan=#{team_zhongyuan.inspect}"
            p "===>team_wudu=#{team_wudu.inspect}"
            if action == "join_zhongyuan"
                
                if team_joined 
                    msg += "<div>あなたが既に#{team_joined}に加入した了</div>"
               elsif team_zhongyuan.size >= max
                    msg += "<div>左冷禅道：閣下、どうもありがとう。私達の手伝いが既に十分。</div>"
                elsif
                    data.set_prop("quest_id", q[:id])
                    data.set_prop("join", "zhongyuan")
                    team_zhongyuan.push(player.id)
                    q.set_prop("zhongyuan", team_zhongyuan)
                    q.save!
                    num = team_zhongyuan.size
                    msg += "<div>「英雄が助けに来てくれて、どうも有難う。ちょっと休憩してください。皆が集まってから一緒に出発しよう！」と左冷禅道拱手の礼をしてから言った。</div>"
                    per = num*100/full
                    if per > 80
                        msg += "<div>あなたが周辺を見て、空いている席が基本的になさそうなので、戦いはそろそろ始まるだろう。"
                    elsif per > 50
                        msg += "<div>あなたが周辺を見て、空いている席がまだ沢山あるようで、もう少し待つだろう。"
                    elsif per > 20
                        msg += "<div>あなたが周辺を見て、空いている席がまだ沢山あるので、早く着いてしまったから、目を閉じて休憩する。"
                    end

                end
            elsif action == "join_wudu"
                if team_joined 
                    msg += "<div>あなたが既に#{team_joined}に加入した</div>"
                elsif team_wudu.size >= max
                    msg += "<div>「私達の手伝いが既に十分なので、英雄、お帰りください。」と苗人女子が言った。</div>"
                elsif
                    data.set_prop("quest_id", q[:id])
                    data.set_prop("join", "wudu")
                    team_wudu.push(player.id)
                    q.set_prop("wudu", team_wudu)
                    q.save
                    num = team_wudu.size
                    msg += "<div>「よしよし、もう１人の手伝いがいてくれる。閣下、どうぞ少し座ってください。我々教主の命令を待ってください。」と苗人女子が拍手して言った。</div>"
                    per = num*100/full
                    if per > 80
                        msg += "<div>あなたが周辺を見て、空いている席が基本的になさそうなので、戦いはそろそろ始まるだろう。"
                    elsif per > 50
                        msg += "<div>あなたが周辺を見て、空いている席がまだ沢山あるようで、もう少し待つだろう。"
                    elsif per > 20
                        msg += "<div>あなたが周辺を見て、空いている席がまだ沢山あるので、早く着いてしまったから、目を閉じて休憩する。"
                    end
                   
                end
            end
                    
                # already joined
                # check player number and time line
                p "====>zhanyikaishi2,team_wudu size #{team_wudu.size}, team zhongyuan size #{team_zhongyuan.size}"
                
             # check can start fight
             # quest_created_at = Time.parse(q[:created_at])
             time_diff = Time.now - q[:created_at]
             p "time_diff=#{time_diff}"
             if (team_wudu.size >= full and team_zhongyuan.size >=full and time_diff > timeup) or (team_wudu.size >= max and team_zhongyuan.size >=max) 
                 p "====>zhanyikaishi1"
                 q[:stat] = 1 # fighting
                 q.save!
                 Process.detach fork{
                     db_reconnected = false
                     puts "waiting for db reconnect"
                     p "qid = #{qid}"
                     i = 100
                     while !db_reconnected and i > 0
                        sleep(1)
                        begin
                            Tradable.find_by_sql("select count(*) from tradables")
                            puts "."
                        rescue
                            p "==>reconnect db"
                             Userext.connection.reconnect! 
                             db_reconnected = true
                        end
                        i -=1
                     end
                       
                 }
                 msg = msg+ "<div>戦い開始!</div>"
                 # sleep 1000
                  doBattle (q)
             end

        
            # data.save!
        end



 
        context[:room] = self.room
        context[:msg] = msg
         p context.inspect
         
    end
    
    # async team fight
    # q: globalquest
    def doBattle(q)
        setGlobalQuest(q)
        Userext.connection.reconnect! 
        p "====>平定五毒教战役开始"
        team_zhongyuan = q.get_prop("zhongyuan")
        team_wudu =q.get_prop("wudu")
     
          # ActiveRecord::Base.establish_connection(ActiveRecord::Base.connection_config)
         msg2 = "<div>五毒教を平定する戦いが開始！</div>"
         team1 = []
         team2 = []
         msg2+="<div>五毒教登場陣容:</div>"
         team_wudu.each {|u|
             user = User.get(u)
             player = Player.new
             player.set_data(user)
            
             player.tmp[:contrib]={
                 :score =>0,
                 :win => 0
             }
             team1.push(player)
             msg2 += "<div><span class='title'>#{user[:title]}</span><span class='user'>#{user[:user]}</span></div>"
        }
        msg2+="<p/>"
        msg2+="<div>中原武術界登場陣容:</div>"
        team_zhongyuan.each {|u|
             user = User.get(u)
             player = Player.new
             player.set_data(user)
          
             player.tmp[:contrib]={
                 :score =>0,
                 :win => 0
             }
             team2.push(player)
             msg2 += "<div><span class='title'>#{user[:title]}</span><span class='user'>#{user[:user]}</span></div>"
      
        }
        
        c = {:msg=>msg2,
            :team1win=>0,
            :team2win=>0,
            :observer=>self
            }
        win = team_fight(team1, team2, c)
        q.set_prop("win", win)
        if win == -1
            c[:msg] += "<div>ドロー!</div>"
        elsif win == 0
   
            c[:msg] += "<div>五毒教が勝った!</div>"
        elsif win == 1
            c[:msg] += "<div>中原武術界が勝った!</div>"
        end
        
        team1.sort_by {|u| u.tmp[:contrib][:score].to_i} 
        team2.sort_by {|u| u.tmp[:contrib][:score].to_i} 
        
        c[:msg] += "<div>五毒教貢献ランキング</div>"
        index_t =1
        for t in team1 
            bonus_gold = t.tmp[:contrib][:score] 
            bonus_exp  = t.tmp[:contrib][:score] 
            if win ==0
                bonus_gold += 20 + bonus_gold/5  # wudujiao has mofre gold bonus
                bonus_exp += 10 
            end
            t.get_exp(bonus_exp)
            t.receive_gold(bonus_gold)
            c[:msg] += "<div><div style='float:left;width:95px;'>#{t.name}が</div><div style='float:left;width:35px;'>#{t.tmp[:contrib][:win]}回勝った</div><!--div style='float:left;width:35px;'>得分#{t.tmp[:contrib][:score]}</div--><div style='float:left;width:80px;'>#{bonus_gold}gold</div><div style='float:left;width:70px;'>#{bonus_exp}点経験</div>が奨励としてもらった<div style='clear:both'></div>"      
          
            if win ==0
                send_msg(t.id, "<div>五毒教が第#{q.get_prop("battle_count")}回の五毒教戦い中に中原武術界を勝った. 戦い貢献ランキングに第#{index_t}位に位置するので, #{bonus_gold}gold, #{bonus_exp}点経験をもらった.")
            end
            qdata=t.query_quest("wudujiao")
            gain = {
                :bonus_gold=>bonus_gold,
                :bonus_exp=> bonus_exp
            }
            qdata.set_prop("gain", gain)
            set_flag(t.id, "db_changed")
            
            
            index_t += 1
        end
        if win == 0
            send_msg(-2, "<div>五毒教が第#{q.get_prop("battle_count")}回の五毒教戦い中に中原武術界を勝った.</div>")
        end
            
        c[:msg] += "<div>中原武術界貢献ランキング</div>"
        index_t =1
        for t in team2
            bonus_gold = t.tmp[:contrib][:score] 
            bonus_exp  = t.tmp[:contrib][:score]
            if win ==1 
                bonus_gold += 20
                bonus_exp += 10 + bonus_exp/5  # zhongyuan has more exp bonus 
            end
            t.get_exp(bonus_exp)
            t.receive_gold(bonus_gold)
            c[:msg] += "<div><div style='float:left;width:95px;'>#{t.name} が</div><div style='float:left;width:35px;'>#{t.tmp[:contrib][:win]}回勝った</div><!--div style='float:left;width:35px;'>得分#{t.tmp[:contrib][:score]}</div--><div style='float:left;width:80px;'>奖励#{bonus_gold}gold</div><div style='float:left;width:70px;'>#{bonus_exp}点経験</div>が奨励としてもらった<div style='clear:both'></div>"
            send_msg(t.id, "<div>中原武術界が第#{q.get_prop("battle_count")}回の五毒教戦い中に五毒教を勝った. 戦い貢献ランキングに第#{index_t}位に位置するので, #{bonus_gold}gold, #{bonus_exp}点経験をもらった.</div>")
            
            qdata=t.query_quest("wudujiao")
            gain = {
                :bonus_gold=>bonus_gold,
                :bonus_exp=> bonus_exp
            }
            qdata.set_prop("gain", gain)
            set_flag(t.id, "db_changed")
            
         
            index_t += 1
        end
        if win == 1
              send_msg(-2, "<div>中原武術界が第#{q.get_prop("battle_count")}回の五毒教戦い中に五毒教を勝った.</div>")
        end
        
        id = q[:id].to_i
        dir = id/100
         dir = "#{g_FILEROOT}/globalquest/#{dir.to_s}"
         begin
             FileUtils.makedirs(dir)
             aFile = File.new("#{dir}/#{id}","a")
             p "==>team fight result #{c[:msg]}"
             aFile.puts c[:msg]
             aFile.close
         rescue Exception=>e
             logger.error e
         end
                       
        team1.each{|p|p.data.check_save}
        team2.each{|p|p.data.check_save}
        q[:stat] = 2
        q[:finishedat] = Time.now
        q.save
        p "==>q:#{q.changed?}- #{q.inspect}"
        
        p "====> 战役结束 <====="
        
                     
    end
    def logo
       "/game/quests/wudujiao.jpg" 
    end
    
    # if exceed full and time is up, battle can start
    # if exceed max, then battle start 
    def full
        5
        # 1
    end
    def max
        10
    end
    def timeup
        3600 *10 # second
        # 10
    end
    
    def globalq(qid)
        if !@q
            @q = Globalquest.find(qid.to_i)
        end
        return @q
    end
    
    def notify(context)
        
        if context[:count]  == nil
            context[:count] =0
        end
        
        p "@q=#{@q.inspect}"
        q = @q
        if q
            q.set_prop("team1win", context[:team1win])
            q.set_prop("team2win", context[:team2win])
            id = q[:id].to_i
            dir = id/100
            dir = "#{g_FILEROOT}/globalquest/#{dir.to_s}"
            begin
              FileUtils.makedirs(dir)
              aFile = File.new("#{dir}/#{id}_#{context[:count]}","a")
              # p "==>team fight result #{context[:msg]}"
              aFile.puts context[:msg]
              aFile.close
              aFile = File.new("#{dir}/#{id}","a")
              # aFile.seek(IO::SEEK_END)
              aFile.puts context[:msg]
              aFile.close
            rescue Exception=>e
              p "Exception: "+e.inspect
            end
            q.save
            context[:count] +=1        
        end
    end
end