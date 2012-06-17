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
  
  def useonbuy
      true
  end
  
  def userCanGet?(context)
      if (context[:c].ext.get_prop("max_item").to_i >= 30)
          context[:m] = "您的物品栏数量以上限, 无法再增加."
          return false
      end
      return true
  end

end