class Tradable < ActiveRecord::Base
    def after_initialize
        t = self
            _t = Equipment.load_equipment(t[:name], t)
            t[:dname] = _t.dname
            t[:desc] = _t.desc
            t[:weight] = _t.desc
            if t[:objtype] == 1
                t[:pos] = _t.wearOn
            end
            t[:intro] = _t.intro
            t[:file] = _t.file
            t[:rank] = _t.rank
    end
end
