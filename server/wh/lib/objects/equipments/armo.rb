require 'objects/equipments/equipment.rb'

class Armo  < Weapon
  def dname
    "铁甲"
  end
  
  def desc
      "这是一副铁质的甲胄，上面似乎还有斑斑血迹，不知是它的主人的血，还是敌人的。"
  end
  
  def wearOn
      "body"
  end
  
  def weight
      20
  end
  
  def image
      "obj/equipments/armo.jpg"
  end
  
    def rank
      5
  end
end