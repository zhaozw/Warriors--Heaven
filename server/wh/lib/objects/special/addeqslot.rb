require 'objects/equipments/weapon.rb'

class Addeqslot  < Game::Object

  def dname
    "装备栏"
  end
  
  def desc
      "添加5个装备栏"
  end


  def image
      "obj/special/addeqslot2.jpg"
  end
  
  def rank
      5
  end
    
  def effect
      "添加5个装备栏"
  end

end