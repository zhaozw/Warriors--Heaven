
   

class Skill
    
   # set activerecord object as skill data
   def set(skill)
       @skill = skill
   end 
   
   def data
       return @skill
   end 
   
   def query_data(n)
       return data[n]
   end
   
   def query(m, p)
       _m = self.method(m)
       _m.call(p)
   end
   
   def []name
       data[name]
   end
end

