module Game
class Object
   def set(obj) 
       @obj = obj
       after_setdata
    end
    
    def after_setdata
        
    end
     
    def self.method_missing(name, *args, &block) # :nodoc:
#      (delegate || superclass.delegate).send(name, *args, &block)
        m = @obj.method(name)
         if m
             return m.call(args)
         else
             return nil
         end
    end
    
    
    def data
        return @obj
    end
    
    def [](n)
        @obj[n]
    end
    
    def []=(n, v)
        @obj[n] = v
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