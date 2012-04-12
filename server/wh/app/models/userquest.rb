class Userquest < ActiveRecord::Base
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
end
