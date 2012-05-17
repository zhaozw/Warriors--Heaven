require 'objects/object.rb'

class Additemslot  < Game::Object

  def dname
    "物品栏"
  end
  
  def desc
      "添加5个物品栏"
  end

  def image
      "obj/special/additemslot.jpg"
  end
  
  def rank
      5
  end
    
  def effect
      "添加5个物品栏"
  end
  def price
      1000
  end
end