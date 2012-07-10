require 'objects/fixtures/fixture.rb'


class Liuweidihuangwan < Fixture
    
    def unit
        "颗"
    end
    
    def dname
        "六位帝黄丸"
    end
    
    def desc
        "由地黄，茯苓等制成，可以提高精力. 据说久服可使人聪慧。"
    end
    
    def intro
        "增加精力 精力恢复100%"
    end
    
    def effect
        "增加精力 精力恢复100%"
    end
    
    def weight
        1
    end
    
    def rank
        3
    end
    
    def image
        "obj/fixtures/liuweidihuangwan.jpg"
    end
    
    def use(context)
        p = context[:player]
        p.ext[:jingli] = p.ext[:max_jl]
        
        p.delete_obj(self)
        context[:msg]="あなたは#{dname}を食べたら、元気いっぱいになった。！"
        
    end
    
    def price
        80
    end
    
       def unlock_level
            0
        end
end