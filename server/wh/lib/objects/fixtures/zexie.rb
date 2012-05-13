require 'objects/object.rb'


class Zexie < Game::Object
    
    def dname
        "泽泻"
    end
    
    def desc
        "这是一株#{dname}，可以入药"
    end
    

    def weight
        1
    end
    
    def rank
        5
    end
    
    def image
        "obj/fixtures/zexie.jpg"
    end
    
    def use(context)
        context[:msg] = "你不要乱吃啊！"
    end
    
    def price
        5
    end
end