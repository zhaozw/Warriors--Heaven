require 'objects/special/special.rb'

class Addeqslot  < Special
    
   def instantiatable
       false
   end
  def dname
    "装备栏"
  end
  
  def desc
      "添加5个装备栏"
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

  def use(context)
      v = context[:player].ext.get_prop("max_eq").to_i
      context[:player].ext.set_prop("max_eq", v+5)
  end
end