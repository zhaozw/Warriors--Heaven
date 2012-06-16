require 'objects/equipments/armo.rb'

class Yanlingjia  < Armo
    def initialize
        super
        set("hp", 100)
    end
  
  
  
  def dname
    "雁翎甲"
  end
  
  def desc
      "传说天宫饲养的大雁所掉落的羽毛制成。柔软而又坚固。"
  end

    
  def wearOn
      "body"
  end
  
  def weight
      20
  end
  
  def image
      "obj/equipments/yanlingjia.jpg?v=2"
  end
  
  def rank
      5
  end
    
  def effect
      "deffence +120"
  end
  

    
  def defense
      120
  end
  

  
  def price
      8000
  end
end