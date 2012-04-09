require 'quests/quest.rb'
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
        [
            "objects/fixures/ginseng",
            "objects/fixures/heshouwu",
            "objects/fixures/dihuang",
            "objects/fixures/fuling",
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
                ar = caoyao_list
                r = caoyao_list[rand(caoyao_list.size)]
                o = create_fixure(r)
                
                user.get_object(o)
                msg = "你挖到了一株#{o.dname} !"
            else
            #msg = "你很用力的挖"
     
                if (rand(100)> luck)
                    npc = create_npc("objects/npc/shanzei")
                    npc.set_temp("level", user.ext("level"))
                    fight(user, npc)
                else
                    msg = "你用药锄拨动着四周的灌木杂草，仔细地看有没有草药"
                end
            end
        else
            msg = "???"
        end
        context[:msg] = msg
    end
        
    
end