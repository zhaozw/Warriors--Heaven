require 'objects/object.rb'


class Shanzhuyu < Game::Object
    
    def dname
        "山茱萸"
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
        "obj/fixtures/shanzhuyu.jpg"
    end
        def use(context)
        context[:msg] = "你不要乱吃啊！"
    end
        def price
        5
    end
end