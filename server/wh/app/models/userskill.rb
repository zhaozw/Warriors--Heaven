class Userskill < ActiveRecord::Base
    def []=(k,v)
       super 
       @changed = true
       # p "''''''userskill[#{k}]=#{v}"
    end
end
