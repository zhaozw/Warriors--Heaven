require 'quests/quest.rb'
require 'fight.rb'
require 'objects/player.rb'

class Yunbiao < Quest 
    def dname
       "运镖" 
    end
    
    def desc
       "江南第一镖局‘神威镖局’公开招聘镖师和趟子手，武艺出众的江湖侠客不妨一试" 
    end
    
    def type
    end
    
    def onAsk(context)
        player = context[:user]
        team = player.query_team
        p "==>team#{team.inspect}"
        if team.values.size < 2
            context[:msg] = "你必须有2名以上队友"
            return false
        end
        return true
    end
    def room
        r = data
        if r[:progress] < 100
            return "高风亮对你说道：这批红货送到慕容庄主那里，务必按时送到，路上小心土匪。"
        else
            return "任务已完成。"
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
                :dname =>"再次领取任务"
            }]
        end
 
    end

    def onAction(context)
        player = context[:user]
        action = context[:action]
     
          if player.ext[:hp] <0 
               context[:msg]="<div>你的HP太低了, 先休息一下吧 !</div>"
            return
        end  
        if player.ext[:stam] <0 
            context[:msg]="<div>你的体力不够， 休息休息吧 !</div>"
            return
        end
        
        msg = ""
        if (action=="go")
            if rand(100) < player.tmp[:luck]
            # if true
                msg += "<div class='row'>你把镖旗一扬，趟子手高喊着‘我～武～威～扬’，车轮沉沉压过地面，引来不少注目</div>"
                r = data
                add_progress(10)
              
            else

                    msg = "<div>忽然跳出3个蒙面人，看样子要劫镖！</div>"
                    for i in 0..2
                        npc = create_npc("objects/npc/gangster")
                        npc.set_temp("level", player.ext[:level])
         
                        _context = {:msg=>""}
                        player[:isUser] = true
                        win = _fight(player, npc, _context)
                        msg +=  _context[:msg]
                        if (player[:gain][:exp] >0)
                            msg += "\n<div class='gain' style='color:#990000'>你的经验值增加了<span style='color:red'>#{player[:gain][:exp]}</span></div>"
                        end
                        if (player[:gain][:level] > 0)
                            msg += "\n<div class='gain' style='color:#990000'>你的等级提升了!</div>"
                        end
                        p "==>win=#{win}"
                        if (win == 1)
                            eqs = npc.query_all_obj
                                eqs.each {|k,v|
                                if v != nil
                                    player.get_obj(v) 
                                    msg += "\n<div class='gain' style='color:#990000'>你得到了一#{v.unit}#{v.dname}!</div>"
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
                           msg += "<div>你眼见不是对手, 只好放弃了镖车。</div>"
                       end
                       
    
            end
        elsif (action=="redo")           
            data[:progress] = 0
            context[:room] = self.room
            p "===>progress1 #{data.inspect}"
        end
        
        p "===>progress #{data.inspect}"
        if data[:progress] >= 100
            msg += "<div> 你终于来到慕容山庄前，庄里的伙计正在那里等着。拍了拍你的肩膀，兄弟辛苦了！</div>"
            add_exp = 100 + rand(player.ext[:luck])
            levelup = player.get_exp(add_exp)
            gold_bonus= 100
            player.ext[:gold] += gold_bonus
            msg +="<div >恭喜你完成了运镖任务. 经验<span style='color:#990000'>+#{add_exp}</span>, Gold<span style='color:#990000'>+#{gold_bonus}</span></div>"
            if levelup
                msg +="<div style='color:#990000'>你的等级提升了!</div>"
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
                    player.addTitle("趟子手")
                elsif r[:c0] < 20
                    player.addTitle("初级镖师")
                elsif r[:c0] < 30
                    player.addTitle("副镖师")
                elsif r[:c0] < 40
                    player.addTitle("镖师")
                elsif r[:c0] < 50 
                    player.addTitle("大镖师")
                elsif r[:c0] < 60
                    player.addTitle("金牌镖师")
                elsif r[:c0] 
                    player.addTitle("总镖师") 
                end
            end
            context[:room] = self.room
        end
        
        context[:msg] += msg
    end
end