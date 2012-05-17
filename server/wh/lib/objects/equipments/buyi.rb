require 'objects/equipments/weapon.rb'

class Buyi  < Armo

  def dname
    "布衣"
  end
  
  def desc
      "这是一件最普通粗布上衣"
  end

    
  def wearOn
      "body"
  end
  
  def weight
      20
  end
  
  def image
      "obj/equipments/buyi.jpg"
  end
  
  def rank
      1
  end
    
  def effect
      "deffence +5"
  end
  

    
  def defense
      10
  end
end