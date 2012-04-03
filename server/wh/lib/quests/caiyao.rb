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
       "/game/quests/logo.png" 
    end
    
    def action_list
        [
            {
                :name=>"dig",
                :dname=>"挖"
            }
        ]
    end
        
    def onAction(context)
        user = context[:user]
        action = context[:action]
        msg = "ddd"
        p action
        if (action=="dig")
            msg = "你很用力的挖"
        else
            msg = "???"
        end
        context[:msg] = msg
    end
        
    
end