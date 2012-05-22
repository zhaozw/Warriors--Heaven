require 'objects/special/special.rb'

class Additemslot  < Special

    def instantiatable
        false
    end
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
  
  def use(context)
      v = context[:player].ext.get_prop("max_item").to_i
      context[:player].ext.set_prop("max_item", v+5)
  end
end