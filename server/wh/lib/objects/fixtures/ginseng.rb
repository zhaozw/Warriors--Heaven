require 'objects/object.rb'


class Ginseng < Herb
    
    def dname
        "人参"
    end
    
    def desc
        "这是一株上好的人参，价值不菲"
    end
    
    def intro
        "大変元気に戻ってる HP+50% 精力恢复100%"
    end
    
    def weight
        1
    end
    
    def rank
        5
    end
    
    def image
        "obj/fixtures/ginseng.png"
    end
    
   def use(context)
        p = context[:player]
        p.ext[:hp] += p.ext[:maxhp]/2
        p.ext[:stam] += p.ext[:maxst]
        
        p.delete_obj(self)
        context[:msg]="あなたは1#{unit}#{dname}を食べたら、元気いっぱいで、力も倍増したようだ。！"
   end 
       def price
        100
    end
        def unlock_level
            0
        end
end