class Userext < ActiveRecord::Base
    def after_initialize
        
     begin   
     prop = JSON.parse(self[:prop])
     prop.each {|k,v|
         self[k] = v   
     }
     
    rescue Exception=>e
        p e
     end
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
        after_initialize
  end
end
