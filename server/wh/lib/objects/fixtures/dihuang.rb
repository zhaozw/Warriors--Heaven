require 'objects/fixtures/herb.rb'


class Dihuang < Herb
    
    def dname
        "生地黄"
    end
    
    def desc
        "这是一株生地黄，可以入药"
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
        "obj/fixtures/dihuang.jpg"
    end
    
        def use(context)
        context[:msg] = "めちゃくちゃに食べないでよ！"
    end
    
    def price
        5
    end
end