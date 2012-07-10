require 'objects/equipments/armo.rb'


class Buyi  < Armo
    def initialize
        super
        set("hp", 50)
    end
  def dname
    "布の服"
  end
  
  def desc
      "これは最も普通の粗布上着である"
  end

    
  def wearOn
      "body"
  end
  
  def weight
      20
  end
  
  def image
      "obj/equipments/buyi.png"
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
    def unlock_level
      0
  end
  def price
      10
  end
end