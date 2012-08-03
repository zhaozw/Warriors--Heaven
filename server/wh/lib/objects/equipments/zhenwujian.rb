require 'objects/equipments/sword.rb'

class Zhenwujian  < Sword


        def initialize
        super
        set("hp", 100)
    end
  def dname
    "真武剑"
  end

  def desc
      "张三丰之佩剑. 武当派创始之祖张三丰的佩剑。 张三丰中年时用它扫荡群邪，威震江湖"
  end
  
  def wearOn
      "hand"
  end
  
  def weight
      81
  end

  def image
      "obj/equipments/zhenwujian3.png"
  end
  
  def effect
      "Damage +100"
  end
  
  def rank
      5
  end
  
  def damage
      100
  end
  
  def price
      10000
  end
  
  # def unlock_level
  #       10
  #   end
end