require 'objects/equipments/equipment.rb'

class Necklace  < Weapon
        def initialize
        super
        set("hp", 100)
    end
    def dname
    "ネックレス"
  end
  
  def desc
      "これは果物のさねより作られたネックレスである"
  end
  
  def wearOn
      "neck"
  end
  def effect
      "luck +2"
  end
  def luck
      2
  end
  def weight
      0
  end
    def image
      "obj/equipments/necklace.jpg"
  end
    def rank
      3
  end
    def price
      100
  end

end