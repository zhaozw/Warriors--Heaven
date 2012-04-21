class Userrsch < ActiveRecord::Base
    def []=(k,v)
       super 
         @changed = true
    end
end
