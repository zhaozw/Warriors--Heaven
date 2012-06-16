require 'objects/equipments/armo.rb'

class Qingtongjia  < Armo
    def initialize
        super
        set("hp", 100)
    end
  
  
  
  def dname
    "青铜甲"
  end
  
  def desc
      "青铜制成的坚固甲胄"
  end

    
  def wearOn
      "body"
  end
  
  def weight
      20
  end
  
  def image
      "obj/equipments/qingtongjia.jpg?v=1"
  end
  
  def rank
      3
  end
    
  def effect
      "defence +20"
  end
  

    
  def defense
      20
  end
  

  
  def price
      200
  end
end