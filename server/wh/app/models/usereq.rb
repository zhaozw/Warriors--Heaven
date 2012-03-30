require 'json'

class Usereq < ActiveRecord::Base
 def after_initialize
     if (self[:prop])
         prop = JSON.parse(self[:prop])
         prop.each {|k,v|
             self[k] = v   
         }
     end
  end
end
