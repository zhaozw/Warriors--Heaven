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
            if rand(100) < player.tmp[:luck]+100
                msg += "<div class='row'>你把镖旗一扬，趟子手高喊着‘我～武～威～扬’，车轮沉沉压过地面，引来不少注目</div>"
                r = data
                add_progress(10)
              
            else

                    msg = "<div>忽然跳出3个蒙面人，看样子要劫镖！</div>"
                    for i in 0..2
                        npc = create_npc("objects/npc/gangster")
                        npc.set_temp("level", player.ext[:level])
         
                        _context = {:msg=>msg}
                        win = _fight(player, npc, _context)
                        msg =  _context[:msg]
                        if (player[:gain][:exp] >0)
                            msg += "\n<div class='gain' style='color:#990000'>你的经验值增加了<span style='color:red'>#{player[:gain][:exp]}</span></div>"
                        end
                        if (player[:gain][:level] > 0)
                            msg += "\n<div class='gain' style='color:#990000'>你的等级提升了!</div>"
                        end
                        if (win)
                            eqs = npc.query_all_equipments
                                eqs.each {|k,v|
                                user.get_obj(v)
                            }
                        else
                            break
                        end
                    end
                    p "===>msg=#{msg}"
                    r = player.query_quest("yunbiao")
                       if win
                           add_progress(38, {:user=>player})
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
            msg +="<div >恭喜你完成了运镖任务. 经验<span style='color:#990000'>+#{add_exp}</span></div>"
            if levelup
                msg +="<div style='color:#990000'>你的等级提升了!</div>"
            end
            context[:room] = self.room
        end
        
        context[:msg] += msg
    end
end