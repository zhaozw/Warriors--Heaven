require 'objects/equipments/weapon.rb'

class Shadai  < Game::Object
    def initialize
        super
        set("hp", 1000)
    end
  def dname
    "沙袋"
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
      "可以用来提高基本拳脚的练习效率"
  end
  def price
      1000
  end
end