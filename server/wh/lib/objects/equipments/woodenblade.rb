require 'objects/equipments/weapon.rb'

class Woodenblade  < Weapon
        def initialize
        super
        set("hp", 100)
    end
    def unit
        "柄"
    end
    def dname
    "木刀"
  end
  
  def desc
      "这是一把硬木制作的刀"
  end
  
  def skill_type
      "daofa"
  end
  
  def wearOn
      "hand"
  end
  
  def weight
      2
  end
  
  def image
      "obj/equipments/woodenblade.png"
  end
  
  def rank
      1
  end

  def damage
      3
  end
  
  def price
      20
  end
    def unlock_level
      0
  end
end