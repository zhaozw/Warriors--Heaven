require 'objects/equipments/equipment.rb'

class Boots  < Weapon
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
    

end