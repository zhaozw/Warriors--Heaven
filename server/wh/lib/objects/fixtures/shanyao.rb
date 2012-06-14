require 'objects/fixtures/herb.rb'


class Shanyao < Herb
    
    def dname
        "山药"
    end
    
    def desc
        "这是一株#{dname}，可以入药"
    end
    
    def intro
        desc
    end
    
    def weight
        1
    end
    
    def rank
        5
    end
    
    def image
        "obj/fixtures/shanyao.jpg"
    end
    def use(context)
        p "use shanyao"
        context[:msg] = "你不要乱吃啊！"
    end
    
        def price
        5
    end
end