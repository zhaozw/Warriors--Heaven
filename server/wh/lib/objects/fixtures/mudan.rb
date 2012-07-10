require 'objects/fixtures/herb.rb'


class Mudan < Herb
    
    def dname
        "牡丹"
    end
    
    def desc
        "这是一株盛开的#{dname}，根皮还可以入药"
    end
    

    def weight
        1
    end
    
    def rank
        5
    end
    
    def image
        "obj/fixtures/mudan.jpg"
    end
    

    def price
        5
    end
end