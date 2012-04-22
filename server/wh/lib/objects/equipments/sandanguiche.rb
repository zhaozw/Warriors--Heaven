require 'objects/equipments/weapon.rb'

class Sandaiguiche  < Weapon
    def dname
    "三代鬼彻"
  end
  
  def desc
      "属于快刀，其系列二代鬼彻和初代鬼彻分别为“大快刀21工”和“无上大快刀12工”。乱刃。之前曾拥有鬼彻的剑士均死于非命。被称为妖刀。只有武力不凡的大师才能驾驭"
  end
  
  def wearOn
      "hand"
  end
  
  def weight
      9
  end
  
  def image
      "obj/equipments/blade.jpg"
  end
  
  def rank
      2
  end

  def damage
      80
  end
end