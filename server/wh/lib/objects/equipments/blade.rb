require 'objects/equipments/weapon.rb'

class Blade  < Weapon
        def initialize
        super
        set("hp", 100)
    end
    def unit
        "柄"
    end
    def dname
    "钢刀"
  end
  
  def desc
      "これはぴかぴか光っている刀である"
  end
  
  def skill_type
      "daofa"
  end
  
  def wearOn
      "hand"
  end
  
  def weight
      5
  end
  
  def image
      "obj/equipments/blade.jpg"
  end
  
  def rank
      2
  end

def effect
    "Damage +20"
end
  def damage
      20
  end
  
  def price
      100
  end

  def unlock_level
      1
  end
end