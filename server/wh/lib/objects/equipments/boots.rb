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
      "这是一双普通武士穿的布靴"
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

end