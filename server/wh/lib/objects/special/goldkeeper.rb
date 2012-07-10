require 'objects/special/special.rb'

class Goldkeeper  < Special

  def dname
    "金庫"
  end
  
  def desc
     "保护你的金银不会在战斗中丢失"
  end

  def image
      "obj/special/baoxiang.jpg"
  end
  
  def rank
      5
  end
    
  def effect
      "あなたの金銀は戦い中に失わないように保護する"
  end
  def price
      1000
  end
end