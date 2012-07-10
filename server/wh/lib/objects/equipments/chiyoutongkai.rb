require 'objects/equipments/armo.rb'

class Chiyoutongkai  < Armo
    def initialize
        super
        set("hp", 100)
    end
  
  
  
  def dname
    "蚩尤铜鎧"
  end
  
  def desc
      "（伝説の覇者が入ってたかっちゅうだ。青銅より構成され、凄く硬い."
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
      "defence +35"
  end
  

    
  def defense
      35
  end
  

  
  def price
      500
  end
end