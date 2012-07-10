require 'objects/special/special.rb'

class Shadai  < Special

    def initialize
        super
        set("hp", 1000)
    end
    
  def dname
    "ゲートル"
  end
  
  def desc
     "金網が入ってるゲートル"
  end

  def image
      "obj/special/shadai.jpg?r=1"
  end
  
  def rank
      5
  end
    
  def effect
      "可以用来提高基本拳脚的练习效率"
  end
  
  def price
      1000
  end
end