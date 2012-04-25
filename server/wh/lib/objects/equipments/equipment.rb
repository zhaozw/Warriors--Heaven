require 'objects/object.rb'

module Game
class Equipment  < Game::Object
  
    def obj_type
        "equipment"
    end
  def intro
        desc
 end
  
  def damage
      0
  end
  
  def defense
      0
  end
    
  def effect
      ""
  end
end
end