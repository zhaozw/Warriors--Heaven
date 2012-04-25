require 'objects/livingobject.rb'

class Player < LivingObject
    

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
        @temp[n] = v
    end
    def query_temp(name)
        if (@obj[name])
            return @obj[name]
        end
        if (@obj.ext[name]) 
            return @obj.ext[name]
        end
        return nil
    end
    
    def query_equipment(position)
    end
    
    def query_quest(quest)
        @obj.query_quest(quest)
    end
    
    def name
        @obj[:user]
    end
    


end