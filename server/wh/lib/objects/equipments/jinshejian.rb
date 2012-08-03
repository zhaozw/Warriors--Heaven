require 'objects/equipments/sword.rb'

class Jinshejian  < Sword


        def initialize
        super
        set("hp", 100)
    end
  def dname
    "金蛇剑"
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
      "obj/equipments/jinshejian2.png?v=1"
  end
  
  def effect
      "Damage +80"
  end
  
  def rank
      5
  end
  
  def damage
      80
  end
  
  def price
      6000
  end
  
  # def unlock_level
  #       10
  #   end
end