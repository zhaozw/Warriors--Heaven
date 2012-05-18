require 'objects/equipments/weapon.rb'

class Blade  < Weapon
    def unit
        "柄"
    end
    def dname
    "钢刀"
  end
  
  def desc
      "这是一个雪亮的钢刀"
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

  def damage
      10
  end
  
  def price
      100
  end
end