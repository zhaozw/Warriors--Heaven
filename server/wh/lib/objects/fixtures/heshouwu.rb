require 'objects/fixtures/herb.rb'


class Heshouwu < Herb
    
    def dname
        "何首乌"
    end
    
    def desc
        "这是一株#{dname}，可以入药"
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
        "obj/fixtures/shouwu.jpg"
    end
    def use(context)
        context[:msg] = "めちゃくちゃに食べないでよ！"
    end
    
    def price
        30
    end
end