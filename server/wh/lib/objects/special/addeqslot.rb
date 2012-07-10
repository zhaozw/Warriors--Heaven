require 'objects/special/special.rb'

class Addeqslot  < Special
    
   def instantiatable
       false
   end
  def dname
    "装備栏"
  end
  
  def desc
      "装備欄五つ増加"
  end


  def image
      "obj/special/addeqslot2.jpg"
  end
  
  def rank
      5
  end
    
  def effect
      "添加5个装备栏"
  end
  
  def price
      1000
  end
  
  def useonbuy
      true
  end
  
  def userCanGet?(context)
      if (context[:c].ext.get_prop("max_eq").to_i >= g_maxeq)
          context[:m] = "あなたの装備欄は既に上限なので、これ以上増加できない。"
          return false
      end
      return true
  end

  def use(context)
      v = context[:player].ext.get_prop("max_eq").to_i
      context[:player].ext.set_prop("max_eq", v+5)
  end
end