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
       #           p "==>prop0=#{prop}"
       #           if prop != nil
       #              prop.each {|k,v|
       #                  @var[k.to_sym] = v
       #                  }
       #           end 
       #       end
       after_setdata
    end
end