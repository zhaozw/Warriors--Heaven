require 'objects/equipments/weapon.rb'

class Blade  < Weapon
    def dname
    "钢刀"
  end
  
  def desc
      "这是一个雪亮的钢刀"
  end
  
  def wearOn
      "hand"
  end
  
  def weight
      5
  end
end