require 'objects/equipments/blade.rb'

class Heidaoqiushui < Blade
    def initialize
        super
        set("hp", 1200)
    end
  def dname
    "黑刀秋水"
  end
  
  def desc
      "　“大快刀二十一工”之一。大逆丁字、黑刀乱刃。斩龙武士龙马所有，传说中武士腰间的名刀。在索隆打败武士龙马之后，龙马托付给索隆，不枉费宝刀之名。"
  end
  
  def skill_type
      "daofa"
  end
  
  def wearOn
      "hand"
  end
  
  def weight
      12
  end
  
  def image
      "obj/equipments/blade.jpg"
  end
  
  def rank
      2
  end

  def damage
      80
  end
    def unlock_level
      20
  end
end