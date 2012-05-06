require 'objects/object.rb'


class Ginseng < Game::Object
    
    def dname
        "人参"
    end
    
    def desc
        "这是一株上好的人参，价值不菲"
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
        "obj/fixtures/ginseng.jpg"
    end
    
   def use(context)
        p = context[:player]
        p.ext[:hp] += p.ext[:max_hp]/2
        p.ext[:stam] += p.ext[:maxt_st]
   end 
end