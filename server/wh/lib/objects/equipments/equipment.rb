require 'objects/object.rb'

class Equipment  < Object
  
  def self.load_equipment(name, obj)
        eval "require 'objects/equipments/"+ name+".rb'"       
        target_class = name.at(0).upcase+name.from(1)
        targetObj=eval target_class+'.new()'
        if (targetObj)
            m = targetObj.method("set")
            m.call(obj)
        end        
        return targetObj
    
  end
  

    
end