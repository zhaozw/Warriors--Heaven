require 'json'

class Usereq < ActiveRecord::Base
 def after_initialize
=begin
     if (self[:prop])
         prop = JSON.parse(self[:prop])
         prop.each {|k,v|
             self[k] = v   
         }
     end
=end
  end
  def set_prop(n,v)
      if (self[:prop])
          j = JSON.parse(self[prop])
      else
          j = {}
        end
        j[n] = v
        self[:prop] = j.to_json
        #save!
  end
  def []=(k,v)
       super 
       @changed = true
    end
end
