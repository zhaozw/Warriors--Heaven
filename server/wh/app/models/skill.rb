class Skill < ActiveRecord::Base
=begin
    def to_json
        p "skill to json2"
        return "{}"
    end
=end
    def []=(k,v)
       super 
       @changed = true
    end
end
