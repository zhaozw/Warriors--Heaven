require 'objects/fixtures/herb.rb'


class Tigerbone < Fixture
    
    def dname
        "虎骨"
    end
    def unit
        "副"
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
        "obj/fixtures/tigerskin.jpg"
    end
    
        def use(context)
        context[:msg] = "你不要乱吃啊！"
    end
        def price
        100
    end
end