require 'objects/equipments/equipment.rb'

class Boots  < Weapon
        def initialize
        super
        set("hp", 100)
    end
    def unit
        "双"
    end
    def dname
    "布靴"
  end
  
  def desc
      "これは普通の武士の布靴である"
  end
  
  def wearOn
      "foot"
  end
  
  def weight
      2
  end
    def image
      "obj/equipments/boots.jpg"
  end
  
    def rank
      1
  end
      def price
      100
  end
    def unlock_level
      1
  end

end