require 'objects/equipments/equipment.rb'

class Ring  < Weapon
    
    def dname
    "铜戒指"
  end
  
  def desc
      "这是一个普通的铜戒指, 又叫顶针箍"
  end
  
  def wearOn
      "finger"
  end

def weight
      0
  end
    def file
      "ring.jpg"
  end
    def rank
      4
  end
end