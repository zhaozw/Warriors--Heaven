require 'objects/fixtures/herb.rb'


class Shedan < Fixture
    
    def dname
        "蛇胆"
    end
    def unit
        "枚"
    end
    def desc
        "这是一#{unit}#{dname}，可以入药"
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
        "obj/fixtures/shedan.png"
    end
    
        def use(context)
        context[:msg] = "你不要乱吃啊！"
    end
        def price
        100
    end
end