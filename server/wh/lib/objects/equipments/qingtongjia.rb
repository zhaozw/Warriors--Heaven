require 'objects/equipments/armo.rb'

class Qingtongjia  < Armo
    def initialize
        super
        set("hp", 100)
    end
  
  
  
  def dname
    "青銅甲"
  end
  
  def desc
      "青銅より作られた固いかっちゅう。"
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