require 'objects/equipments/weapon.rb'

class Sword  < Weapon
    
  def dname
    "铁剑"
  end
  
  def desc
      "这是一把普通的铁剑"
  end
  
  def wearOn
      "hand"
  end
  
  def weight
      7
  end
    def image
      "obj/equipments/sword.jpg"
  end
  def rank
      1
  end
end