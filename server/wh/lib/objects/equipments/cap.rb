require 'objects/equipments/weapon.rb'

class Cap  < Weapon
  
  def dname
    "铁头盔"
  end
  
  def desc
      "这是一个铁质的头盔"
  end
  
  def wearOn
      "head"
  end
  
  def weight
      5
  end
  
  def image
      "obj/equipments/cap.jpg"
  end

  def rank
      1
  end
  
  def effect
      "deffence +5"
  end
  
  def price
      100
  end
  
  def defense
      5
  end
  
end