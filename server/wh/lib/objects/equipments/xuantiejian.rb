require 'objects/equipments/weapon.rb'

class Xuantiejian  < Sword


        def initialize
        super
        set("hp", 100)
    end
  def dname
    "玄铁剑"
  end

  def desc
      "上古玄铁制成，重九九八十一斤，剑长逾三尺，通体深黑，却隐隐透出红光"
  end
  
  def wearOn
      "hand"
  end
  
  def weight
      81
  end

  def image
      "obj/equipments/xuantiejian.jpg"
  end
  
  def effect
      "Damage +50"
  end
  
  def rank
      4
  end
  
  def damage
      50
  end
  
  def price
      500
  end
  
  # def unlock_level
  #       10
  #   end
end