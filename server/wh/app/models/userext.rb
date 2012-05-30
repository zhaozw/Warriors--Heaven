class Userext < ActiveRecord::Base
    def after_initialize
=begin        
     begin   
     prop = JSON.parse(self[:prop])
     prop.each {|k,v|
         self[k] = v   
     }
     
    rescue Exception=>e
        p e
     end
=end
  end
  
    def []=(k,v)
       super 
        @changed = true
    end
    def set_prop(n,v)
      if (self[:prop])
          j = JSON.parse(self[:prop])
      else
          j = {}
      end
      
      j[n] = v
      self[:prop] = j.to_json
      #save!
      # after_initialize
  end
    def delete_prop(n)
      if (self[:prop])
          j = JSON.parse(self[:prop])
      else
          j = {}
      end
      
      j.delete(n)
      self[:prop] = j.to_json
      #save!
      # after_initialize
  end
  def get_prop(k)
        if !self[:prop]
            return nil
        end
        #p "===>prop=#{self[:prop]}"
        j = JSON.parse(self[:prop])
       # p "===>inspect prop=#{j.inspect}"
        if j
            return j[k]
        else
            return nil
        end
    end
end
