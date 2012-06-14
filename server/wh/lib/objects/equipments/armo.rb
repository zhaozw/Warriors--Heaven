require 'objects/equipments/equipment.rb'

class Armo  < Game::Equipment
    def initialize
        super
        set("hp", 100)
    end
  
  def unit
      "件"
  end
  
  def dname
    "铁甲"
  end
  
  def desc
      "这是一副铁质的甲胄，上面似乎还有斑斑血迹，不知是它的主人的血，还是敌人的。"
  end

    
  def wearOn
      "body"
  end
  
  def weight
      20
  end
  
  def image
      "obj/equipments/armo.jpg"
  end
  
  def rank
      2
  end
    
  def effect
      "deffence +5"
  end
  

    
  def defense
      10
  end
  
  def unlock_level
         p "==>self class is #{self.class}"
      if self.class.to_s =='Armo'
          return 1
      else
          return super
      end
  end
  
  def price
      100
  end
  
end