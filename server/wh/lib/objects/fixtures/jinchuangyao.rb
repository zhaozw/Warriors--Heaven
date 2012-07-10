require 'objects/fixtures/fixture.rb'


class Jinchuangyao < Fixture
    
    def initialize
        super
        p "init jinchuangyao #{@var.inspect}"
        set("dname", "金疮药")
    end
    
    def dname
        "金疮药"
    end
    
    def unit
        "包"
    end
    
    def desc
        intro
    end
    
    def intro
       "这是一盒金疮药，可以用来治疗外伤."
    end
    
    def effect
        "治疗外伤 HP+20"
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
    
    def price
        50
    end
    
    def use(context)
        p = context[:player]
        # p.ext[:hp] += p.ext[:maxhp]/5
        p.ext[:hp] += 20
        
        p.delete_obj(self)
        context[:msg]="あなたは1#{unit}#{dname}を食べたら、傷口がだんだんふさがった！！"
    end
    
end
# Jinchuangyao.new