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
            "objects/fixures/ginseng",
            "objects/fixures/heshouwu",
            "objects/fixures/fuling",
            "objects/fixures/dihuang",
            "objects/fixures/shanzhuyu",
            "objects/fixures/zexie",
            "objects/fixures/shanyao",
        ]
    end
    def onAction(context)
        user = context[:user]
        action = context[:action]
  
        p action
        srand(Time.now.tv_usec.to_i)
        if (action=="dig")
            luck = user.ext[:luck]
            if (rand(100)<luck) # get caiyao
        #  if (false)
                ar = caoyao_list
                
                r = caoyao_list[rand(100-luck)/(luck/caoyao_list.size)]
                o = create_fixure(r)
                
                user.get_object(o)
                msg = "<div><span style='color:#990000'>你挖到了一株<span style='color:red'>#{o.dname}</span></span> !</div>"
                r = user.query_quest("caiyao")
                r[:progress] += 10
                r.save!
            else
            #msg = "你很用力的挖"
     
                if (rand(100)> luck)
                    msg = "<div>忽然跳出一个蒙面山贼，看样子要杀了你！</div>"
                    npc = create_npc("objects/npc/shanzei")
                    npc.set_temp("level", user.ext[:level])
                    player = Player.new
                    player.set(user)
                    _context = {:msg=>msg}
                    _fight(player, npc, _context)
                    msg =  _context[:msg]
                    if (player[:gain][:exp] >0)
                        msg += "\n<div class='gain' style='color:#990000'>你的经验值增加了<span style='color:red'>#{player[:gain][:exp]}</span></div>"
                    end
                    if (player[:gain][:level] > 0)
                        msg += "\n<div class='gain' style='color:#990000'>你的等级提升了!</div>"
                    end
                    p "===>msg=#{msg}"
                else
                    msg = "<div>你用药锄拨动着四周的灌木杂草，仔细地看有没有草药</div>"
                end
            end
        else
            msg = "???"
        end
        context[:msg] = msg
        p context.inspect
    end
        
    
end