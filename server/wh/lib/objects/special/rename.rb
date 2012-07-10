require 'objects/special/special.rb'

class Rename  < Special

    def instantiatable
        false
    end
  def dname
    "改名符"
  end
  
  def desc
     "あなたの名前変更に使える"
  end

  def image
      "obj/special/rename.jpg?r=1"
  end
  
  def rank
      5
  end
    
  def effect
      "あなたの名前変更に使える"
  end
  def price
      1000
  end
end