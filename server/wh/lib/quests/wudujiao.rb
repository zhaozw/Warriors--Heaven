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
            if q[:stat] == 1
                return [
                    {
                        :name=>"check_result",
                        :dname=>"查看战役结果"
                    
                    }]
            end
        end
    end
    
    def onAction(context)
        player = context[:user]
        action = context[:action]
       
       msg = ""
       
       
       qid = data.get_prop("quest_id")
       if !qid # havn't join team

            # try to join
            r = player.query_quest("caiyao")
            if !r or r[:progress] < 100
            else
                if action == "join_zhongyuan"
                    msg += "<div>你向右走上，来到群雄面前, 想要加入。</div>"
                    msg += "<div>左冷禅对你说：云南山岚瘴气甚多，无毒教更是遍布毒虫，小兄弟对草药一无所知，还是不要去送了性命。</div>"
                elsif action == "join_wudu"
                    msg += "<div>你向前进入无毒教地界。</div>"
                    msg += "<div>一个苗人打的年轻女子拦住了你：阁下百草不识，帮不上什么，不如请回吧。</div>"
                end
                context[:msg] += msg
                return
            end
         
            # passed check, set quest id
            rs = Globalquest.find_by_sql("select * from globalquests where stat=0")
            if !rs or rs.size == 0 # not globalquest
                    g = Globalquest.new({
                        :name=>"wudujiao",
                        :stat=>0,
                        :prop =>{
                            :wudu=>[player.id],
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
            
            # join
            
            if action == "join_zhongyuan"
                num = q.get_prop("zhongyuan").size
                msg += "<div>左冷禅拱手说道：多谢英雄前来助战，请稍事休息，等大伙汇集齐了便一同出发！</div>"
                per = num*100/full
                if per > 80
                    msg += "<div>你看了看周围，已经基本没有空座，看来战役快开始了。"
                elsif per > 50
                    msg += "<div>你看了看周围，似乎还有不少座位空着，看样子等一会儿。"
                elsif per > 20
                    msg += "<div>你看了看周围，空着不少座位，看来你来的早了，于是闭目养神。"
                end
                data.set_prop("join", "zhongyuan")
            elsif action == "join_wudu"
                num = q.get_prop("zhongyuan").size
                msg += "<div>苗人女子拍手乐道：好好，我们又多了一个帮手，阁下坐一哈子，等我们教主号令。</div>"
                per = num*100/full
                if per > 80
                    msg += "<div>你看了看周围，已经基本没有空座，看来战役快开始了。"
                elsif per > 50
                    msg += "<div>你看了看周围，似乎还有不少座位空着，看样子先等一会儿。"
                elsif per > 20
                    msg += "<div>你看了看周围，空着不少座位，看来你来的早了，于是闭目养神。"
                end
                data.set_prop("join", "wudu")
            end
                    
                # already joined
                # check player number and time line
             # check can start fight
             if r.get_prop("wudu").size >= full and r.get_prop("zhongyuan").size >=full
                 p "====>zhanyikaishi1"
                 Process.detach fork{
                     slee(10)
                     p "====>zhanyikaishi"
                 }
                 msg = msg+ "战役开始!"
             end

        else
             
            if action=="check_result"
            end
        end



 
        
        context[:msg] = msg
         p context.inspect
    end
    def logo
       "/game/quests/wudujiao.jpg" 
    end
    def full
        10
    end
    def globalq(qid)
        if !@q
            @q = Globalquest.find(qid.to_i)
        end
        return @q
    end
end