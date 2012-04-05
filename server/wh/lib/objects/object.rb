module Game
class Object
   def set(obj) 
       @obj = obj
    end
    
    def method_missing(method)
        nil
    end
    
    def data
        return @obj
    end
=begin    
    def dname
        "金疮药"
    end
    
    def desc
        "这是一盒金疮药，可以用来治疗外伤."
    end
    
    def intro
        "治疗外伤 HP+20%"
    end
    
    def weight
        1
    end
    
    def rank
        1
    end
    
    def file
        "jinchuangyao.jpg"
    end
=end
end
end