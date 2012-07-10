require 'objects/equipments/weapon.rb'

class Xuantiejian  < Sword


        def initialize
        super
        set("hp", 100)
    end
  def dname
    "神鉄の剣"
  end

  def desc
      "鉄より作られ、81斤、3尺である。全体黒いが、赤い光も通っているようである"
  end
  
  def wearOn
      "hand"
  end
  
  def weight
      81
  end

  def image
      "obj/equipments/xuantiejian.jpg"
  end
  
  def effect
      "Damage +50"
  end
  
  def rank
      4
  end
  
  def damage
      50
  end
  
  def price
      500
  end
  
  # def unlock_level
  #       10
  #   end
end