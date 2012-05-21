require 'objects/equipments/equipment.rb'

class Necklace  < Weapon
        def initialize
        super
        set("hp", 100)
    end
    def dname
    "项链"
  end
  
  def desc
      "这是一个果核做的项链"
  end
  
  def wearOn
      "neck"
  end
  
def weight
      0
  end
    def image
      "obj/equipments/necklace.jpg"
  end
    def rank
      3
  end
    def price
      100
  end
end