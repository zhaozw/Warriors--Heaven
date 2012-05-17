require 'objects/equipments/weapon.rb'

class Rename  < Game::Object

  def dname
    "改名符"
  end
  
  def desc
     "可以用来修改你的名字"
  end

  def image
      "obj/special/rename.jpg"
  end
  
  def rank
      5
  end
    
  def effect
      "可以用来修改你的名字"
  end
  def price
      1000
  end
end