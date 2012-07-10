require 'objects/fixtures/herb.rb'


class Fuling < Herb
    
    def dname
        "茯苓"
    end
    
    def desc
        "这是一株#{dname}，可以入药"
    end
    
    def intro
        "HP+70%"
    end
    
    def weight
        1
    end
    
    def rank
        5
    end
    
    def image
        "obj/fixtures/fuling.jpg"
    end
    
        def use(context)
        context[:msg] = "めちゃくちゃに食べないでよ！"
    end
        def price
        10
    end
end