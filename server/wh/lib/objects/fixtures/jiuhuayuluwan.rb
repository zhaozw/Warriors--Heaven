require 'objects/fixtures/fixture.rb'


class Jiuhuayuluwan < Fixture
    
    def initialize
        super
        p "init Fixture #{dname} #{@var.inspect}"
        set("dname", "九花玉露丸")
    end
    
    def unit
        "颗"
    end
    
    def dname
        "九花玉露丸"
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
        "obj/fixtures/jiuhuayuluwan.jpg"
    end
    
    def price
        50
    end
    
    def use(context)
        p = context[:player]
        p.ext[:hp] += p.ext[:maxhp]/5
        
        p.delete_obj(self)
        context[:msg]="你服下一#{unit}#{dname}, 伤处渐渐愈合！"
    end
    
end
