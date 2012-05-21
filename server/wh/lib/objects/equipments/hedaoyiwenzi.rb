require 'objects/equipments/weapon.rb'

class Hedaoyiwenzi  < Blade
        def initialize
        super
        set("hp", 1200)
    end
    def dname
    "和道一文字"
  end
  
  def desc
      "“大快刀二十一工”之一,直刃、白涂鞘太刀拵，又称为“约定之刃”"
  end
  
  def wearOn
      "hand"
  end
  
  def skill_type
      "daofa"
  end
  
  def weight
      9
  end
  
  def image
      "obj/equipments/hedao.jpg"
  end
  
  def rank
      2
  end

  def damage
      80
  end
end