require 'objects/fixtures/fixture.rb'


class Yudongheishidan < Fixture
    
    def initialize
        super
        p "init Fixture #{dname} #{@var.inspect}"
        set("dname", "玉洞黑石丹")
    end
    
    def unit
        "颗"
    end
    
    def dname
        "玉洞黑石丹"
    end
    
    def desc
        intro
    end
    
    def intro
        "崆峒派疗伤圣药，专治七伤拳引起的内伤。"
    end
    
    def effect
        "可治疗七伤拳引起的内伤"
    end
    
    def weight
        1
    end
    
    def rank
        2
    end
    
    def image
        "obj/fixtures/yudongheishidan.gif"
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
        def unlock_level
            0
        end
end

