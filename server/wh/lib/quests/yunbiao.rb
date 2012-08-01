require 'quests/quest.rb'
require 'fight.rb'
require 'objects/player.rb'

class Yunbiao < Quest 
    def dname
       "運送護衛" 
    end
    
    def desc
       "江南第一運送店「神威運送店」がメンバーを募集しているので、武芸に優れている方々は試してみないか。" 
    end
    
    def type
    end
    
    def onAsk(context)
        player = context[:user]
        team = player.query_team
        p "==>team#{team.inspect}"
        if team.values.size < 2
            context[:msg] = "2名以上のチームメンバーが必須だ"
            return false
        end
        return true
    end
    def room
        r = data
        if r[:progress] < 100
            return "「この赤い荷物を慕容荘主の所に運送してください。必ず時間通りに出発してください。悪者に気をつけてください。」と高風亮があなたに言った。"
        else
            return "任務完成。"
        end
    end
    
    def logo
       "/game/quests/yunbiao.jpg" 
    end
    
    def action_list
        l = [
                {
                    :name=>"go",
                    :dname=>"运镖"
                }
            ]
        r = data
        if r[:progress] < 100
            return l
        else
            return [ { 
                :name=>"redo",
                :dname =>"改めて任務を受け取る"
            }]
        end
 
    end

    def onAction(context)
        player = context[:user]
        action = context[:action]
     
          if player.ext[:hp] <0 
               context[:msg]="<div>あなたhpが足りないので, ゆっくり休めてね!</div>"
            return
        end  
        if player.ext[:stam] <0 
            context[:msg]="<div>あなたの体力が足りないので、ゆっくり休めてね!</div>"
            return
        end
        
        msg = ""
        if (action=="go")
            if rand(100) < player.tmp[:luck]
            # if true
                msg += "<div class='row'>あなたが旗を揚げ、チームメンバーが大きな声で「私～武～威～揚」と叫んでいた。地面が車輪の下敷きになり、沢山の人々に注目された。</div>"
                r = data
                add_progress(10)
              
            else

                    msg = "<div>突然、顔を覆った3人が現れてきて、荷物を強奪としていた。！</div>"
                    for i in 0..2
                        npc = create_npc("objects/npc/gangster")
                        npc.set_temp("level", player.ext[:level])
         
                        _context = {:msg=>""}
                        player[:isUser] = true
                        win = _fight(player, npc, _context)
                        msg +=  _context[:msg].gsub(/<div class='st_lines'.*?<\/div>/i, "").gsub(/<div class=.status.>.*?<\/div>/mi, "")
                        if (player[:gain][:exp] >0)
                            msg += "\n<div class='gain' style='color:#990000'>あなたの経験値が増加した<span style='color:red'>#{player[:gain][:exp]}</span></div>"
                        end
                        if (player[:gain][:level] > 0)
                            msg += "\n<div class='gain' style='color:#990000'>あなたのレベルがアップされた!</div>"
                        end
                        p "==>win=#{win}"
                        if (win == 1)
                            eqs = npc.query_all_obj
                                eqs.each {|k,v|
                                if v != nil
                                    player.get_obj(v) 
                                    msg += "\n<div class='gain' style='color:#990000'>あなたが一つの#{v.dname}をゲットした!</div>"
                                end
                            }
                        else
                            break
                        end
                    end
                    p "===>msg=#{msg}"
                    r = player.query_quest("yunbiao")
                       if win == 1
                           add_progress(38)
                       else
                           r[:progress] = 0
                           msg += "<div>あなたが相手になれないと分り、車を放棄してしまった。</div>"
                       end
                       
    
            end
        elsif (action=="redo")           
            data[:progress] = 0
            context[:room] = self.room
            p "===>progress1 #{data.inspect}"
        end
        
        p "===>progress #{data.inspect}"
        if data[:progress] >= 100
            msg += "<div>あなたがやっと慕容山荘の前に来た。お店の店員がそこで待っていた。あなたの肩を叩き、お疲れ様！</div>"
            add_exp = 100 + rand(player.ext[:luck])
            levelup = player.get_exp(add_exp)
            gold_bonus= 100
            player.ext[:gold] += gold_bonus
            msg +="<div >護衛任務完成、おめでとう. 、経験<span style='color:#990000'>+#{add_exp}</span>, Gold<span style='color:#990000'>+#{gold_bonus}</span></div>"
            if levelup
                msg +="<div style='color:#990000'>あなたのレベルがアップされた!</div>"
            end
            rs = Rank.find_by_sql("select * from ranks where uid=#{player.id}")
            r = nil
            if !rs || rs.size==0
                r = Rank.new({
                    :uid=>player.id,
                    :c0=>1,
                    :c1=>0,
                    :c2=>0,
                    :c3=>0,
                    :c4=>0,
                    :c5=>0,
                    :c6=>0,
                    :c7=>0,
                    :c8=>0,
                    :c9=>0   
                })
                r.save!
            else
                r = rs[0]
                r[:c0] += 1
                r.save!
            end
            if r
                if r[:c0] < 10
                    player.addTitle("従者")
                elsif r[:c0] < 20
                    player.addTitle("初級師匠")
                elsif r[:c0] < 30
                    player.addTitle("副師匠")
                elsif r[:c0] < 40
                    player.addTitle("師匠")
                elsif r[:c0] < 50 
                    player.addTitle("大師匠")
                elsif r[:c0] < 60
                    player.addTitle("ゴールデン師匠")
                elsif r[:c0] 
                    player.addTitle("総師匠") 
                end
            end
            context[:room] = self.room
        end
        
        context[:msg] += msg
    end
end