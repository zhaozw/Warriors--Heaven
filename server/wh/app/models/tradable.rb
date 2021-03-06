class Tradable < ActiveRecord::Base
    def after_initialize
        t = self
        begin
            _t = Equipment.load_equipment(t[:name], t)
            t[:dname] = _t.dname
            t[:desc] = _t.desc
            t[:weight] = _t.weight
            if t[:obtype] == 1
                t[:pos] = _t.wearOn
            end
            t[:intro] = _t.intro
            t[:image] = _t.image
            t[:rank] = _t.rank
        rescue Exception =>e
            logger.error e.inspect
            p e.inspect
        end
    end
    def []=(k,v)
       super 
       @changed = true
    end
end
