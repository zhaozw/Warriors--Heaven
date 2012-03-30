class Userext < ActiveRecord::Base
    def after_initialize
     prop = JSON.parse(self[:prop])
     prop.each {|k,v|
         self[k] = v   
    }
  end
end
