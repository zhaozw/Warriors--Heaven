require 'objects/equipments/weapon.rb'

class Woodensword  < Weapon


    def initialize
        super
        set("hp", 100)
    end
    
  def dname
    "木剑"
  end
    
  def skill_type
      "fencing"
  end
  
  def desc
      "这是一把普通的硬木制成的剑"
  end
  
  def wearOn
      "hand"
  end
  
  def weight
      2
  end

  def image
      "obj/equipments/woodensword.png"
  end
  
  def effect
      "Damage +3"
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