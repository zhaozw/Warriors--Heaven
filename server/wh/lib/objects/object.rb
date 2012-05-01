module Game
class Object
    
# -------- CONVENTION ----------
# @var    attributes of instance and can be modified during game, like hp of object
# @obj    database record
# @temp   temporary variable, usually copy from database record when initialize. 
#         The purpos is to prevent modifying database directly. Usually used for one time, like passive fight
# Method like "dname" define the static attribute of object
# ------------------------------
    
    def initialize
        p "object init"
        @var = {}
    end
    
    def set(n, v)
        @var[n] = v
    end
    
    def get(n)
        @var[n]
    end
    
    def vars
        @var
    end
    
    def set_data(obj) 
       @obj = obj
       after_setdata
    end
    
    def obj_type
        "object"
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
    
    def price
        0
    end
    
    
    #dummy method
    def effect
        ""
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