require "fight.rb"
class Wudujiao < Quest 
    def dname
       "平定五毒教"
    end
    
    def desc
       "云南五毒教，以用毒出名，最近来到中原挑战各大门派，急需人手应付" 
    end
    
    def type
    end

    def room
        
       qid = data.get_prop("quest_id")
       p "==>qid=#{qid.inspect}"
       if !qid
           return "这里通往五毒教的必经之路，前面就是黑压压的大山，向右是一条官道，远处人声马嘶，似乎聚集了很多人，应该就是中原武林人士临时集结之所。"
       end
       
       q = globalq(qid)
       msg = ""
        if q[:stat] == 0
            if  data.get_prop("join") == "zhongyuan"
                msg += "<div>这是一个临时搭建的帐篷，供中原群雄休息。</div>"
         
            else
                msg += "<div>这是一个敞亮的大厅, 供五毒教教众和外援们休息。</div>"

            end


            return msg
        elsif q[:stat] == 1
            
            return "战役进行中。目前五毒教胜#{q.get_prop("team1win")}阵，中原武林胜#{q.get_prop("team1win")}阵"
        elsif q[:stat] == 2
            return "战役已经结束。五毒教胜#{q.get_prop("team1win")}阵，中原武林胜#{q.get_prop("team1win")}阵"
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
                msg += "<div>你看了看周围，已经基本没有空座，看来战役快开始了。"
            elsif per > 50
                msg += "<div>你看了看周围，似乎还有不少座位空着，看样子等一会儿。"
            else
                msg += "<div>你看了看周围，空着不少座位，看来你来的早了，于是闭目养神。"
            end

            return msg
        end
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
                :dname=>"加入五毒教"
            },
            {
                :name=>"join_zhongyuan",
                :dname=>"加入中原武林"
            },
        ]
        else
            q = globalq(qid.to_i)
                    p "====>action_list q=#{q.inspect}"
            if q[:stat] == 2
                return [
                    {
                        :name=>"check_result",
                        :dname=>"战役实况录像"
                    
                    },
                    {
                        :name=>"restart",
                        :dname=>"重新获取任务"
                    
                    },
                    ]
            elsif q[:stat] == 1
                    {
                        :name=>"check_result",
                        :dname=>"查看战役直播"
                    
                    }
                 
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
       if !qid # havn't join team
            
            # try to join
            r = player.query_quest("caiyao")
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
            if !rs or rs.size == 0 # not globalquest
                g = Globalquest.new({
                    :name=>"wudujiao",
                    :stat=>0,
                    :prop =>{
                        :wudu=>[],
                        :zhongyuan=>[]
                    }.to_json
                })
                g.save!
                data.set_prop("quest_id", g.id)
            else    # globalquest existing
                 data.set_prop("quest_id", rs[0].id)
        
            end
            r = rs[0]
            q = r
      end
      
      if !q
          q = globalq(qid)
      end
                             p "====>zhanyikaishi22"           
      if action=="check_result"
          
          context[:script]="location.replace('/wh/teamfight?id=#{qid}');"
          return
      elsif action =="restart"
          data.set_prop("quest_id", nil)
          context[:room] = self.room
          return
        
      else  
          
        # join
            team_zhongyuan = q.get_prop("zhongyuan")
            team_wudu =q.get_prop("wudu")
            team_joined = nil
            if team_zhongyuan.include?(player.id) 
                team_joined = "中原武林"
            elsif  team_wudu.include?(player.id) 
                team_joined = "五毒教"
            end
            p "===>team_zhongyuan=#{team_zhongyuan.inspect}"
            p "===>team_wudu=#{team_wudu.inspect}"
            if action == "join_zhongyuan"
                
                if team_joined 
                    msg += "<div>你已经加入过#{team_joined}了</div>"
                else
                    data.set_prop("join", "zhongyuan")
                    team_zhongyuan.push(player.id)
                    q.set_prop("zhongyuan", team_zhongyuan)
                    q.savenum = team_zhongyuan.size
                    msg += "<div>左冷禅拱手说道：多谢英雄前来助战，请稍事休息，等大伙汇集齐了便一同出发！</div>"
                    per = num*100/full
                    if per > 80
                        msg += "<div>你看了看周围，已经基本没有空座，看来战役快开始了。"
                    elsif per > 50
                        msg += "<div>你看了看周围，似乎还有不少座位空着，看样子等一会儿。"
                    elsif per > 20
                        msg += "<div>你看了看周围，空着不少座位，看来你来的早了，于是闭目养神。"
                    end

                end
            elsif action == "join_wudu"
                if team_joined 
                    msg += "<div>你已经加入过#{team_joined}了</div>"
                else
                    data.set_prop("join", "wudu")
                    team_wudu.push(player.id)
                    q.set_prop("wudu", team_wudu)
                    q.save
                    num = team_wudu.size
                    msg += "<div>苗人女子拍手乐道：好好，我们又多了一个帮手，阁下坐一哈子，等我们教主号令。</div>"
                    per = num*100/full
                    if per > 80
                        msg += "<div>你看了看周围，已经基本没有空座，看来战役快开始了。"
                    elsif per > 50
                        msg += "<div>你看了看周围，似乎还有不少座位空着，看样子先等一会儿。"
                    elsif per > 20
                        msg += "<div>你看了看周围，空着不少座位，看来你来的早了，于是闭目养神。"
                    end
                   
                end
            end
                    
                # already joined
                # check player number and time line
                p "====>zhanyikaishi2,team_wudu size #{team_wudu.size}, team zhongyuan size #{team_zhongyuan.size}"
                
             # check can start fight
             if team_wudu.size >= full and team_zhongyuan.size >=full
                 p "====>zhanyikaishi1"
                 q[:stat] = 1 # fighting
                 q.save
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
                    p "====>平定五毒教战役开始"
                      # ActiveRecord::Base.establish_connection(ActiveRecord::Base.connection_config)
                     msg2 = "<div>平定五毒教战役开始</di>"
                     team1 = []
                     team2 = []
                     msg2+="<div>五毒教出场阵容:</div>"
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
                    msg2+="<div>中原武林出场阵容:</div>"
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
                    if win == 1
                        c[:msg] += "<div>平局!</div>"
                    elsif win == 1
                        c[:msg] += "<div>五毒教获胜!</div>"
                    elsif win == 0
                        c[:msg] += "<div>中原武林获胜!</div>"
                    end
                    
                    team1.sort_by {|u| u.tmp[:contrib][:score].to_i} 
                    team2.sort_by {|u| u.tmp[:contrib][:score].to_i} 
                    
                    c[:msg] += "<div>五毒教贡献榜</div>"
                    for t in team1 
                        c[:msg] += "<div>#{t.name} 胜#{t.tmp[:contrib][:win]}场，得分#{t.tmp[:contrib][:score]}</div>"
                    end
                    c[:msg] += "<div>中原武林贡献榜</div>"
                    for t in team2
                        c[:msg] += "<div>#{t.name} 胜#{t.tmp[:contrib][:win]}场，得分#{t.tmp[:contrib][:score]}</div>"
                    end
                    
                    id = q[:id].to_i
                                 dir = id/100
                                 dir = "/var/wh/globalquest/#{dir.to_s}"
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
                     q.save
                     
                 }
                 msg = msg+ "<div>战役开始!</div>"
                 # sleep 1000
             end

        
     
        end



 
        context[:room] = self.room
        context[:msg] = msg
         p context.inspect
         
    end
    def logo
       "/game/quests/wudujiao.jpg" 
    end
    def full
        4
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
        
        q = globalq(data.get_prop("quest_id"))
        if q
            q.set_prop("team1win", context[:team1win])
            q.set_prop("team2win", context[:team2win])
            id = q[:id].to_i
            dir = id/100
            dir = "/var/wh/globalquest/#{dir.to_s}"
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