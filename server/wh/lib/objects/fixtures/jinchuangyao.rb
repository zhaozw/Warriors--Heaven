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
    
    def desc
        "这是一盒金疮药，可以用来治疗外伤."
    end
    
    def intro
        "治疗外伤 HP+50"
    end
    
    def effect
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
    
    def price
        50
    end
    
    def use(context)
        p = context[:player]
        p.ext[:hp] += p.ext[:maxhp]/5
        
        p.delete_obj(self)
        context[:msg]="你服下一包金疮药, 伤处渐渐愈合！"
    end
    
end
# Jinchuangyao.new