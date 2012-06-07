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
        "增加精力 精力恢复00%"
    end
    
    def weight
        1
    end
    
    def rank
        5
    end
    
    def image
        "obj/fixtures/liuweidihuangwan.jpg"
    end
    
    def use(context)
        p = context[:player]
        p.ext[:jingli] = p.ext[:max_jl]
        
        p.delete_obj(self)
        context[:msg]="你服下一颗六位地黄丸，顿时觉得精力充沛！"
        
    end
    
    def price
        80
    end
end