require 'objects/equipments/blade.rb'

class Xuezou  < Blade
        def initialize
        super
                set("max_hp", 1200)
        set("hp", 1200)
    end
    def dname
        "雪走"
    end

    def desc
        "　“良快刀50工”之一。为罗格镇武器店的镇店之宝，武器店老板受索隆与三代鬼彻比试运气之举所震慑，将此镇店之宝免费赠与索隆"
    end

    def skill_type
        "daofa"
    end

    def wearOn
        "hand"
    end

    def weight
        10
    end

    def image
        "obj/equipments/xuezou.jpg"
    end

    def rank
        5
    end

    def damage
        50
    end
     
    def price
      1000
    end
    
    def intro
        "　“良快刀50工”之一。为罗格镇武器店的镇店之宝，"
    end
    
    def effect
      "Damage +50"
    end
end