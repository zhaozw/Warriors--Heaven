require 'objects/equipments/equipment.rb'

class Necklace  < Weapon
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
    def file
      "necklace.jpg"
  end
end