class Equipment < ActiveRecord::Base
    def self.load_equipment(name, obj)
        p obj.inspect
        if obj[:obtype] == 2 or obj[:eqtype] == 2 
            eval "require 'objects/fixures/"+ name+".rb'"  
        else
            eval "require 'objects/equipments/"+ name+".rb'"  
        end     
        target_class = name.at(0).upcase+name.from(1)
        targetObj=eval target_class+'.new()'
        if (targetObj)
            m = targetObj.method("set")
            m.call(obj)
        end        
        return targetObj
    
    end
    
end
