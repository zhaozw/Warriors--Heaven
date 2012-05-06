def create_npc(path)
    o = loadGameObject(path)
    return o
end

def create_equipment(path)
    create_fixure(path)
end

def create_fixure(path)
        o = Equipment.new({
                    :eqname=>path,
                    :eqtype=>2,
                    :prop=>"{}",
                    :owner =>0
                })
        # o.save!
      
        r = loadGameObject(path)
        r.set_data(o)
        return r
    end
    def load_obj(path, o)
        r = loadGameObject(path)
        r.set_data(o)
        return r
    end
=begin
def translate_msg msg, context
    if (!msg)
        return ""
    end
#    userext = context[:user].ext
    target = context[:target]
    p "=>msg = #{msg}"
    p "=>target = #{target.inspect}"
    return msg.gsub(/\$N/m, "你").gsub("/\$n/m", target.name)
end
=end
    def loadGameObject(path)
        p "require '"+ path+".rb'"
        eval "require '"+ path+".rb'"      
        b = path.split('/')
        name = b[b.size-1]
        target_class = name.at(0).upcase+name.from(1)
        targetObj=eval target_class+'.new()'
        
    #    targetObj.set(o) if o
        return targetObj
        
    end
    
    def queryGameObject(targetObj, method, params)
         m = targetObj.method(method)
         return m.call(params)
    end
    
   
   # load skill object, without user data
    def load_skill (skillname, data = nil)
             # eval skill class
                eval "require 'skills/"+ skillname+".rb'"
               
                target_class = skillname.at(0).upcase+skillname.from(1)
                targetObj=eval target_class+'.new()'
                targetObj.set_data(data) if data
                return targetObj
                
    end
=begin 
    def query_skill(skillname, method, skill, context)
         targetObj = load_skill(skillname)
         m = targetObj.method("set")
         m.call(skill)
         
         m = targetObj.method(method);
        if (method == "for" or method=="type")
             return m.call()
         else
             return m.call(context)
         end
    end
=end   
    def query_obj(objname, method, obj, context)
        eval "require 'objects/"+ objname+".rb'"         
        target_class = objname.at(0).upcase+objname.from(1)
        targetObj=eval target_class+'.new()'
        m = targetObj.method("set");
        m.call(obj)
        
        m = targetObj.method(method);
        if context
            return m.call(context)
        else
            return m.call
        end
         
    end
    
    def add_exp(add_exp)
        
    end

    # def move_obj(v,p)
    #     r = v.data
    #     if !r
    #         
    #     end
    # end
    
    def getfiles(path)  
        re = []  
        allre = []  
        Dir.foreach(path) do |f|  
            allre << f  
        end  
        allre.each do |f|  
            fullfilename = path + "/" + f  
            if f == "." or f == ".."   
            elsif File.directory?(fullfilename)  
                resub = []  
                resub = getfiles(fullfilename)  
          
                if resub.length > 0  
                    ref = {}  
                    ref[f] = resub  
                    re << ref  
                end  
            elsif File.exist?(fullfilename) and (f =~ /\.rb$/) # only rb file  
                re << f  
            end  
        end  
        return re  
    end
    
    def calc_total_exp(level)
        p "==>level=#{level}"
        return 0 if level==0
        r  = 0
        for i in 1..level
            r += i*i*i
        end
        p "=>exp of level #{level} is #{r}"
        return r
    end
