
require 'objects/object.rb'


class Gold < Game::Object
    
    def dname
        "黄金"
    end
    
    def desc
        "这是一枚金币"
    end
    
    def intro
        "一枚金币"
    end
    
    def weight
        1
    end
    
    def rank
        5
    end
    
    def image
        "obj/fixtures/gold.jpg"
    end
    
    def use(context)
        context[:msg] = "你不要乱吃啊！"
    end
    
    def price
        1
    end
end