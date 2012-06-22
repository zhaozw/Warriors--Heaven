require 'objects/object.rb'


class Lingzhi < Herb
    
    def dname
        "灵芝"
    end
    
    def desc
        "这是一株上好的人参，价值不菲"
    end
    
    def intro
        "大补元气 HP+70% 精力全满"
    end
    
    def weight
        1
    end
    
    def effect
        "大补元气 HP+70% 精力全满"
    end
    def rank
        4
    end
    
    def image
        "obj/fixtures/lingzhi.jpg"
    end
    
   def use(context)
        p = context[:player]
        p.ext[:hp] += p.ext[:maxhp]/2
        p.ext[:stam] += p.ext[:maxst]
        
        p.delete_obj(self)
        context[:msg]="你服下一#{unit}#{dname}，顿时觉得精神百倍，力气大增！"
   end 
       def price
        100
    end
          def unlock_level
            0
        end
end