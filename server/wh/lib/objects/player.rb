require 'objects/human.rb'

class Player < Human
    

    def initialize
        @wearing={}
    end
    
    def isUser
        true
    end
    
    def tmp
        if (!@obj[:userext]) 
            @obj.ext
        end
        if (@temp == nil)
            setup_temp
        end
         return @temp
    end
    
    def after_setdata
        setup_temp
        setup_wearing
    end
    
    def setup_wearing
        ext = @obj.ext
         prop =  ext[:prop]
        if (prop)
            j_prop = JSON.parse(prop)
            eqslot = j_prop["eqslot"]
            if eqslot
                 if eqslot.class == String
                    eqslot = JSON.parse(eqslot)
                     p "===>2.2#{eqslot}"
                 end
                 eqslot.each {|k,v|
                          if k[0] < 48 or k[0] > 57
                         r = Equipment.find(v)
                         if r 
                           eq = load_obj(r[:eqname], r)
                           if eq.obj_type == 'equipment'
                             wear(eq, k)
                            end
                         end
                     end
                     
                 }
            end
            
        end
    end
    
    def setup_temp
        p "setup_temp for #{@obj[:user]}"
        if (!@obj[:userext]) 
            @obj.ext
        end
        @temp = {
            :leve =>@obj[:userext][:level  ],
              :exp   => @obj[:userext][:exp  ],
              :str   => @obj[:userext][:str  ],
              :hp    => @obj[:userext][:hp   ],
              :maxhp => @obj[:userext][:maxhp],
              :dext  => @obj[:userext][:dext ],
              :stam  => @obj[:userext][:stam ],
              :maxst => @obj[:userext][:maxst],
              :luck => @obj[:userext][:luck],
              :it  =>@obj[:userext][:it],
              :fame    =>@obj[:userext][:fame],
              :race    =>@obj[:userext][:race],
              :pot     =>@obj[:userext][:pot]
          }
          prop =  JSON.parse(@obj[:userext][:prop])
          prop.each {|k,v|
             @temp[k] = v   
         }
    end
    
    def ext
        @obj[:userext]
    end
    def setup_skill
        
    end
    def name
        @obj[:user]
    end
    
    def query_skill(name)
        @obj.query_skill(name)
    end
    def query_all_skills
        return @obj.query_all_skills
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
    
    def query_equipment(position)
        if !@worn_eq
            @worn_eq = {}
            eqslot = @obj.ext.get_prop("eqslot")
            p "===>eqslot=#{eqslot}"
            if eqslot
                if eqslot.class == String
                    eqslot = JSON.parse(eqslot)
                end
                eqslot.each{|k,v|
                    @worn_eq[k.to_sym] = v
                }
            end
                     p "===>@worn_eq=#{@worn_eq}"
        end
        id = @worn_eq[position.to_sym]
        if id
            eq = Usereq.find(id)
        
            return load_obj(eq[:eqname], eq)
        end
        
        return nil
        
    end
    
    def query_quest(quest)
        @obj.query_quest(quest)
    end
    
    def name
        @obj[:user]
    end
    
    def set_skill(n,l,tp)
       @obj.set_skill(n,l,tp) 
    end
    


end