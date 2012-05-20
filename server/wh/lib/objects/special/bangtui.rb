require 'objects/equipments/weapon.rb'

class Shadai  < Game::Object

  def dname
    "绑腿"
  end
  
  def desc
     "一副灌了铁砂的bangtui"
  end

  def image
      "obj/special/shadai.jpg?r=1"
  end
  
  def rank
      5
  end
    
  def effect
      "可以用来提高基本拳脚的练习效率"
  end
  def price
      1000
  end
end