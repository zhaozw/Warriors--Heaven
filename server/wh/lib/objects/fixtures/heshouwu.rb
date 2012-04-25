require 'objects/object.rb'


class Heshouwu < Game::Object
    
    def dname
        "何首乌"
    end
    
    def desc
        "这是一株上好的人参，价值不菲"
    end
    
    def intro
        "大补元气 HP+70%"
    end
    
    def weight
        1
    end
    
    def rank
        5
    end
    
    def image
        "obj/fixtures/ginseng.jpg"
    end
    
    
end