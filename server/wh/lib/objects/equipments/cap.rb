require 'objects/equipments/weapon.rb'

class Cap  < Weapon
      def initialize
        super
        set("hp", 100)
    end
  def dname
    "鉄のヘルメット"
  end
  
  def desc
      "これは鉄のヘルメットである"
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