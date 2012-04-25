require 'objects/object.rb'


class Jinchuangyao < Game::Object
    
    def dname
        "金疮药"
    end
    
    def desc
        "这是一盒金疮药，可以用来治疗外伤."
    end
    
    def intro
        "治疗外伤 HP+50"
    end
    
    def weight
        1
    end
    
    def rank
        1
    end
    
    def image
        "obj/fixtures/jinchuangyao.jpg"
    end
    
    
end