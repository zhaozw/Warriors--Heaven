require 'objects/equipments/weapon.rb'

class Woodensword  < Weapon


    def initialize
        super
        set("hp", 100)
    end
    
  def dname
    "木の剣"
  end
    
  def skill_type
      "fencing"
  end
  
  def desc
      "これは普通の硬い木より作られた剣である"
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