require 'objects/special/special.rb'

class Additemslot  < Special

    def instantiatable
        false
    end
  def dname
    "物品栏"
  end
  
  def desc
      "品物欄五つ増加"
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
      if (context[:c].ext.get_prop("max_item").to_i >= g_maxitem)
          context[:m] = "あなたの品物欄は既に上限なので、これ以上増加できない."
          return false
      end
      return true
  end

end