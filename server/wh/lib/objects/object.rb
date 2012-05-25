module Game
class Object
    
# -------- CONVENTION ----------
# @var    attributes of instance and can be modified during game, and stored in "prop" field of db record, like hp of object. 
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
        data[n]
    end
    
    def []=(n, v)
        data[n] = v
    end
    
    def price
        0
    end
    
    def unit
        ""
    end
    
   def setProp(n,v)
       
        data[:prop]=util_set_prop(data[:prop], n, v) if data

  end

    def getProp(k)
        if  data
            util_get_prop(data[:prop], k)
        else
            return nil
        end
    end
    
    def hp(h=nil)
        if data
            _h= getProp("hp") 
            if h != nil
                _h = h
                setProp("hp", _h)
            end
            return _h
        else
            return 0
        end
    end
    
    def to_hash
        hash = {
            :dname=>dname,
            :image=>image,
            :effect=>effect,
            :desc=>desc,
            :price=>price,
            :weight=>weight,
            :rank=>rank,
            :unit=>unit
        }.merge(vars)
        if data && (data[:eqtype].to_i==1   || data[:eqtype].to_i==3 ) 
            hash[:damage] = damage
            hash[:defense] = defense
            hash[:pos] = wearOn
            hash[:wearOn] = wearOn
        end
        # self.instance_variables.each {|var| 
        #            hash[var.to_s.delete("@")] = self.instance_variable_get(var)
        #         }
       
       if (data)
      
            hash = hash.merge(data.attributes)
        else

        end
        return hash
    end
    
    def to_json(*opt)

      to_hash.to_json(*opt)
   end
    
    def instantiatable
        true
    end
    
    #dummy method
    def effect
        ""
    end
        def weight
        0
    end
    
    def rank
        0
    end
    
    def price
        0
    end
    
    def id
        if data
            return data[:id]
        else
            return super
        end 
    end
    
    def use(context)
    end
    # for tradable
    def intro
      desc
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
    

    
    def file
        "jinchuangyao.jpg"
    end
=end
    def useonbuy # for tradables
        false
    end
end
end