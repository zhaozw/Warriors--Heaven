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
        "崆峒派の非常に良い薬で、七傷拳でなった内部器官の傷に一番効く。"
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
        context[:msg]="あなたは1#{unit}#{dname}を食べたら、傷口がだんだんふさがった！"
    end
        def unlock_level
            0
        end
end

