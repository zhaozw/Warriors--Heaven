module Character
    # incept to cut out the _obj part
     def set_data(obj) 
       @obj = obj
       # @obj[:_obj] = self
       #       prop = obj[:prop]
       #       if prop != nil
       #           if prop.class == String
       #               prop = JSON.parse(prop)
       #           end
       #           p "==>prop0=#{prop}"/
       #           if prop != nil
       #              prop.each {|k,v|
       #                  @var[k.to_sym] = v
       #                  }
       #           end 
       #       end
       after_setdata
    end
    
    def data
        return @obj
    end
    
    def tmp
        @temp
    end
    
    def set_temp(n, v)
        if !@temp
            setup_temp
        end
        @temp[n.to_sym] = v
    end
    def query_temp(name)
        # if (@obj[name])
        #     return @obj[name]
        # end
        # if (@obj.ext[name]) 
        #     return @obj.ext[name]
        # end
        # if !@temp
        #     setup_temp
        # end
        # return @temp[nam]
        return tmp[name.to_sym]
    end
end