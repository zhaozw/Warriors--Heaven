require 'objects/equipments/weapon.rb'

class Cap  < Weapon
      def initialize
        super
        set("hp", 100)
    end
  def dname
    "铁头盔"
  end
  
  def desc
      "这是一个铁质的头盔"
  end
  
  def wearOn
      "head"
  end
  
  def weight
      5
  end
  
  def image
      "obj/equipments/cap.jpg?r=1"
  end

  def rank
      2
  end
  
  def effect
      "defence +5"
  end
  
  def price
      100
  end
  
  def defense
      5
  end
    def unlock_level
      1
  end
end