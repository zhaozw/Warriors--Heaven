require 'quests/quest.rb'
require 'fight.rb'
require 'objects/player.rb'

class Caiyao < Quest 
    def dname
       "采药" 
    end
    
    def desc
       "行走江湖，必须懂得如何采到必备的草药，以备不时只需." 
    end
    
    def type
    end
    
    def room
        "这是一片山中的树林，可能生长着各种草药.听说运气好的话，还能挖到人参等珍贵的药材。"
    end
    
    def logo
       "/game/quests/caiyao.png" 
    end
    
    def action_list
        [
            {
                :name=>"dig",
                :dname=>"挖"
            }
        ]
    end
    
    def caoyao_list
        [ # from expensive to cheap
            "objects/fixtures/ginseng",
            "objects/fixtures/heshouwu",
            "objects/fixtures/fuling",
            "objects/fixtures/dihuang",
            "objects/fixtures/shanzhuyu",
            "objects/fixtures/zexie",
            "objects/fixtures/shanyao",
            "objects/fixtures/mudan"
        ]
    end
    
    def onAsk(context)

        return true
    end
    def onAction(context)
        user = context[:user]
        action = context[:action]
         player = user
          if player.ext[:hp] <0 
     
               context[:msg]="<div>你的HP太低了, 先休息一下吧 !</div>"
     
            return
        end  
        if player.ext[:stam] <0 
        
                context[:msg]="<div>你的体力不够， 休息休息吧 !</div>"
         
            return
        end
  
  
        p action
        srand(Time.now.tv_usec.to_i)
        if (action=="dig")
            luck = user.ext[:luck]
            if (rand(100)<luck) # get caiyao
        #  if (false)
                ar = caoyao_list
                if (luck < caoyao_list.size)
                    luck = caoyao_list.size
                end
                # r = caoyao_list[rand(100-luck)/(luck/caoyao_list.size)]
                r = caoyao_list[rand(ar.size)-rand(luck)*ar.size/100]
                o = create_fixure(r)
                
                user.get_obj(o)
                msg = "<div><span style='color:#990000'>你挖到了一株<span style='color:red'>#{o.dname}</span></span> !</div>"
                r = user.query_quest("caiyao")
                progress = 10
                if (r[:progress] < 100)
                    add_progress(progress)
               
                # r.save!
                
                    if r[:progress] >= 100 && 
                        exp_bonus = 10+rand(user.tmp[:luck])/10
                        # levelup = user.add_exp(exp_bonus)
                        levelup = user.get_exp(exp_bonus)
                        msg += "<div><span style='color:#990000'>Quest complete !</span><span>&nbsp;Exp +#{exp_bonus}</span></div>\n"
                        if (levelup)
                            msg+="<div><span style='color:#990000'>Level Up !</div>"
                        end

                    end
                end
                user.ext[:stam] -=5
            else
            #msg = "你很用力的挖"
     
                if (rand(100)> luck)
                    msg = "<div>忽然跳出一个蒙面山贼，看样子要杀了你！</div>"
                    npc = create_npc("objects/npc/shanzei")
                    npc.set_temp("level", user.ext[:level])
         
                    _context = {:msg=>msg}
                    win = _fight(player, npc, _context)
                    msg =  _context[:msg]
                    if (player[:gain][:exp] >0)
                        msg += "\n<div class='gain' style='color:#990000'>你的经验值增加了<span style='color:red'>#{player[:gain][:exp]}</span></div>"
                    end
                    if (player[:gain][:level] > 0)
                        msg += "\n<div class='gain' style='color:#990000'>你的等级提升了!</div>"
                    end
                    p "===>msg=#{msg}"
                    if (win)
                        eqs = npc.query_all_equipments
                        eqs.each {|k,v|
                            user.get_obj(v)
                        }
                        
                    end
                else
                    msg = "<div>你用药锄拨动着四周的灌木杂草，仔细地看有没有草药</div>"
                    user.ext[:stam] -=5
                end
            end
        else # action != "dig"
            msg = "???"
        end
        context[:msg] = msg
        p context.inspect
    end
        
    
end