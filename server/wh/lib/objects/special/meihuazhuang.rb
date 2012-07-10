require 'objects/special/special.rb'

class Meihuazhuang  < Special
    def initialize
        super
        set("max_hp", 1000)
        set("hp", 1000)
    end
  def dname
    "梅花樁"
  end
  
  def desc
     "6根木桩，按梅花形状排列。加速你的轻功练习速度"
  end

  def image
      "obj/special/meihuazhuang.jpg?r=2"
  end
  
  def rank
      5
  end
    
  def effect
      "あなたのダッジ練習スピードをアップ"
  end
  def price
      1000
  end

    def sell_price
      price * get("hp") / get("max_hp")
  end
end