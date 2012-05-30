require 'utility.rb'
class Quest

    # set user
    def setPlayer(player)
        @p = player
    end
    
    # set userquest record
    def setData(d)
        @d = d
    end
    
    def data
        @d
    end
    
    def bgimage
        "/images/quest_bg.png"
    end
    def logo
       "/game/quests/logo.png" 
    end
    
    def set_progress(p)
        return if !data
        data[:progress] = p
    end
    def add_progress (progress)
        # cls = self.class.to_s
        #    cls = cls.at(0).downcase+cls.from(1)
        #    
        #    r = context[:user].query_quest(cls)
        r = data
        p "===>3"+r.inspect
        r[:progress] += progress
        if r[:progress] > 100
            r[:progress] = 100
        end
        if r[:progress] == 100
            r[:count] = 0 if r[:count] == nil
            r[:count] += 1
        end
    end
    
    def room_welcome
        ""
    end
    
    
    

end