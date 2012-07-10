require 'objects/equipments/equipment.rb'

class Armo  < Game::Equipment
    def initialize
        super
        set("hp", 100)
    end
  
  def unit
      "件"
  end
  
  def dname
    "鉄甲"
  end
  
  def desc
      "これは鉄のかっちゅうで、上に血痕がまだつけられているようであるが、主人の血なのか、ライバルの血なのかは分からない。"
  end

    
  def wearOn
      "body"
  end
  
  def weight
      20
  end
  
  def image
      "obj/equipments/armo.jpg"
  end
  
  def rank
      2
  end
    
  def effect
      "defence +10"
  end
  

    
  def defense
      10
  end
  
  def unlock_level
         p "==>self class is #{self.class}"
      if self.class.to_s =='Armo'
          return 1
      else
          return super
      end
  end
  
  def price
      100
  end
  
end