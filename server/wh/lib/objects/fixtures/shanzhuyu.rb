require 'objects/fixtures/herb.rb'


class Shanzhuyu < Herb
    
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
        "obj/fixtures/shanzhuyu.png"
    end

        def price
        5
    end
end