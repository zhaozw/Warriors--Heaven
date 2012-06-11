require 'objects/object.rb'

module Game
class Equipment  < Game::Object
  
    def obj_type
        "equipment"
    end
    def desc
        ""
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
  
  def image
  end
  def dname
      ""
  end
  def unlock_level
      (rank-1)*10
  end
=begin
    def to_json(*opt)
     # p "skill to json"
    #   return "{}"
        hash = {
            :dname=>dname,
            :image=>image,
            :effect=>effect,
            :desc=>desc
        }
        # self.instance_variables.each {|var| 
        #            hash[var.to_s.delete("@")] = self.instance_variable_get(var)
        #         }
       
       if (data)
           # p "===>return #{@skill.inspect}"
            # return @skill.to_json(*opt)
            hash = hash.merge(data.attributes)
        else
            # p "==>return {}"
            # return 
        end
        return hash.to_json(*opt)
   end
=end
end
end