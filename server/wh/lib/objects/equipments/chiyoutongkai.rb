require 'objects/equipments/armo.rb'

class Chiyoutongkai  < Armo
    def initialize
        super
        set("hp", 100)
    end
  
  
  
  def dname
    "蚩尤铜铠"
  end
  
  def desc
      "传说中霸王蚩尤穿过的盔甲,青铜制成，坚固无比。"
  end

    
  def wearOn
      "body"
  end
  
  def weight
      30
  end
  
  def image
      "obj/equipments/chiyoutongkai.jpg?v=1"
  end
  
  def rank
      4
  end
    
  def effect
      "deffence +35"
  end
  

    
  def defense
      35
  end
  

  
  def price
      500
  end
end