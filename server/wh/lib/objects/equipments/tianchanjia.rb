require 'objects/equipments/weapon.rb'

class Tianchanjia  < Armo
    def initialize
        super
        set("hp", 100)
    end
  def dname
    "天蚕甲"
  end
  
  def desc
      "西域天蚕丝制成的宝甲"
  end

    
  def wearOn
      "body"
  end
  
  def weight
      20
  end
  
  def image
      "obj/equipments/tiancanjia.jpg"
  end
  
  def rank
      5
  end
    
  def effect
      "deffence +5"
  end
  
  def price
      5000
  end
    
  def defense
      100
  end
end