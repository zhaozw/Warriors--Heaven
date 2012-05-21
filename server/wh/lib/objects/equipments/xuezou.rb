require 'objects/equipments/blade.rb'

class Xuezou  < Blade
        def initialize
        super
        set("hp", 1200)
    end
    def dname
        "雪走"
    end

    def desc
        "　“良快刀50工”之一。黑漆太刀持、乱刃小丁子。为罗格镇的武器店的镇店之宝，武器店老板受索隆与三代鬼彻比试运气之举所震慑，将此镇店之宝免费赠与索隆"
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
        3
    end

    def damage
        120
    end
     
    def price
      500
    end
end