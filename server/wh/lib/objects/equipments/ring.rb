require 'objects/equipments/equipment.rb'

class Ring  < Weapon
        def initialize
        super
        set("hp", 100)
    end
    def dname
    "铜戒指"
  end
  
  def desc
      "这是一个普通的铜戒指, 又叫顶针箍"
  end
  
  def wearOn
      "finger"
  end
  def luck
      1
  end
  def weight
      0
  end
    def image
      "obj/equipments/ring.jpg"
  end
    def rank
      2
  end
  def effect
      "Damage +3\nLuck +1"
  end
  def damage
      3
  end
    def price
      100
  end
    def unlock_level
      1
  end
end