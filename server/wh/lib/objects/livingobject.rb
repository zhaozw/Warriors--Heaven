require 'objects/object.rb'


class LivingObject < Game::Object
    @wearing={}
     
    def initialize
        @wearing={}
    end
    def wear(eq, pos)
        return if !eq
        if !@wearing
            @wearing = {}
        end
        @wearing[pos] = eq
    end
    def query_wearing(pos)
        if !@wearing
            @wearing = {}
        end
        return @wearing[pos]
    end
    def query_all_wearings
        if !@wearing
            @wearing = {}
        end
        return @wearing
    end
    
end