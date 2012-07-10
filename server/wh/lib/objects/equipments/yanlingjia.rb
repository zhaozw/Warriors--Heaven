require 'objects/equipments/armo.rb'

class Yanlingjia  < Armo
    def initialize
        super
        set("hp", 100)
    end
  
  
  
  def dname
    "紫金雁翎甲"
  end
  
  def desc
      "（伝説の天宮が飼ってた雁から落ちた羽で作られた。柔らかいながら、丈夫である。"
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