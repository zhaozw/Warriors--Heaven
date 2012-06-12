require 'objects/equipments/sword.rb'

class Ningbijian  < Sword


        def initialize
        super
        set("hp", 100)
    end
  def dname
    "凝碧剑"
  end

  def desc
      "尖利无比、青光耀眼、如一泓秋水。武当派火手判官张召重佩剑，曾用此剑砍断陈家洛和无尘道长的兵器。后张召重落入狼城绝境，为群狼所噬，此剑终被其同门陆菲青保管"
  end
  
  def wearOn
      "hand"
  end
  
  def weight
      10
  end

  def image
      "obj/equipments/ningbijian.jpg"
  end
  
  def effect
      "Damage +10"
  end
  def rank
      3
  end
  
  def damage
      10
  end
  
  def price
      100
  end
  

end