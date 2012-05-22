require 'objects/special/special.rb'

class Muren  < Special
  
    def initialize
        super
        set("max_hp", 1000)
    end
  
  def dname
    "木人"
  end
  
  def desc
     "一个5尺高的木人，可以自行挥动拳脚向你进攻。加速你的基本招架练习速度"
  end

  def image
      "obj/special/muren.jpg?r=33"
  end
  
  def rank
      5
  end
    
  def effect
      "加速你的基本招架练习速度"
  end
  
  def price
      1000
  end

end