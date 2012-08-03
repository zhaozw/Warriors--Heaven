require 'objects/equipments/boots.rb'

class Yufenglv  < Boots
        def initialize
        super
        set("hp", 100)
    end
    def unit
        "双"
    end
    def dname
    "御风履"
  end
  
  def desc
      "玄阴地火炼制而成，有“乘风游八荒”之美誉"
  end
  
  def wearOn
      "foot"
  end

  def effect
      "defense +5
damage +3
dodge +3
fdfa1
dfasfa2
dsfasf3"
  end
  
  def defense
      5
  end
  def damage
      3
  end
  def weight
      2
  end
    def image
      "obj/equipments/yufenglv.jpg"
  end
  
    def rank
      2
  end
      def price
      200
  end
    def unlock_level
      5
  end

end