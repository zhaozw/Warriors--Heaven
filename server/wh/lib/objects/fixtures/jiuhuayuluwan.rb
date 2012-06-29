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
        "黄药师独门灵丹妙药，以清晨九种花瓣上的露水调制而成，外呈朱红色，清香袭人，服后补神健体，延年益寿"
    end
    
    def intro
        "解百毒 治疗内外伤 HP+100%"
    end
    
    def effect
        "解百毒 治疗内外伤 HP+100%"
    end
    
    def weight
        1
    end
    
    def rank
        4
    end
    
    def image
        "obj/fixtures/jiuhuayuluwan.gif"
    end
    
    def price
        100
    end
    
    def use(context)
        p = context[:player]
        p.ext[:hp] = p.ext[:maxhp]
        p.release_poisoned
        
        p.delete_obj(self)
        context[:msg]="你服下一#{unit}#{dname}, 觉得一股清气贯通全身！"
        
    end
        def unlock_level
            0
        end
    
end

