require 'objects/equipments/weapon.rb'

class Sword  < Weapon


        def initialize
        super
        set("hp", 100)
    end
  def dname
    "铁剑"
  end
    
  def skill_type
      "fencing"
  end
  
  def desc
      "这是一把普通的铁剑"
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
      "Damage +30"
  end
  def rank
      2
  end
  
  def damage
      30
  end
  
  def price
      100
  end

end