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
  
  def effect
      "defense +2
damage +1
dodge +3"
  end
  
  def defense
      2
  end
  def damage
      1
  end
  
  def weight
      2
  end
    def image
      "obj/equipments/buxue.png"
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