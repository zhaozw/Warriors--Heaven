require 'objects/special/special.rb'

class Shadai  < Special
    def initialize
        super
        set("max_hp", 1000)
        set("hp", 1000)
    end
  def dname
    "砂袋"
  end
  
  def desc
     "一个灌满了沙子的皮袋，可以用来提高基本拳脚的练习效率"
  end

  def image
      "obj/special/shadai.jpg?r=1"
  end
  
  def rank
      5
  end
    
  def effect
      "基本拳法の練習効率アップに使える"
  end
  def price
      1000
  end
    def sell_price
      price * get("hp") / get("max_hp")
  end
end