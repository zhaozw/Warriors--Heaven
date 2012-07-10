require 'objects/equipments/weapon.rb'

class Sword  < Weapon


        def initialize
        super
        set("hp", 100)
    end
  def dname
    "鉄の剣"
  end
    
  def skill_type
      "fencing"
  end
  
  def desc
      "これは普通の鉄の剣である"
  end
  
  def wearOn
      "hand"
  end
  
  def weight
      7
  end

  def image
      "obj/equipments/sword.jpg?r=1"
  end
  
  def effect
      "Damage +20"
  end
  def rank
      2
  end
  
  def damage
      20
  end
  
  def price
      100
  end
  def unlock_level
      p "==>self class is #{self.class}"
      if self.class.to_s=='Sword'
          return 1
      else
          return super
      end
  end
  
end